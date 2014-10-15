MetaJSON = require"lib.metarow.MetaJSON"

local jsonString

describe( "basic functions", function ( )
  setup( function ( )
    local f = io.open( 'specs/metarow/view_string.json', "r" )
    jsonString = f:read( "*a" )
  end)

  it( "stores empty table for no JSON string", function( )
    local d = MetaJSON()
    assert.is_not_nil( d )
    assert.is_true( type( d.data ) == 'table')
    assert.are.equals( 0, #d.data )
  end)

  it( "stores parsed JSON data", function( )
    local d = MetaJSON{ json = jsonString }
    assert.is_not_nil( d )
    assert.is_true( type( d.data ) == 'table')
    assert.are.equals( 4, #d.data )
    assert.are.equals( 'createRect', d.data[1].fun.name )
  end)

  it( "sets data from new JSON string", function( )
    local d = MetaJSON()
    d:setData( jsonString )
    assert.is_true( type( d.data ) == 'table')
  end)

  it( "works with added functions", function( )
    local d = MetaJSON{ json = jsonString }
    d.createRect = function( )
      return 1
    end
    assert.is_true( type( d['createRect'] ) == 'function' )
    assert.are.equals( 1, d[d.data[1].fun.name]( ) )
  end)

  it( "handles MetaJSON key val", function( )
    local d = MetaJSON{ json = '{ "val" : 1 }' }
    assert.are.equals( 1, d:getMeta( d.data ))
  end)

  it( "parses params key", function( )
    local d = MetaJSON{ json = [[
      {
        "params" : {
          "x" : { "val" : 1 },
          "y" : { "val" : 1 },
          "width" :  { "fun" : { "name":"screenWidth" }},
          "height" : { "fun" : { "name":"screenHeight" }},
          "fill" : { "val" : [1, 1, 1] },
          "stroke" : { "val" : [0.5, 0.5, 0.5] },
          "strokeWidth" : { "val" : 2 }
        }
      }
    ]] }
    d.screenWidth = function( )
      return 768
    end
    d.screenHeight = function( )
      return 1024
    end
    local params = d:getParams( d.data )
    assert.are.equals( 2, params.strokeWidth )
    assert.are.equals( 768, params.width)
  end)

  it( "handles MetaJSON key fun", function( )
    local d = MetaJSON{ json = jsonString }
    d.createRect = function( params )
      return params.width
    end
    d.screenWidth = function( )
      return 768
    end
    d.screenHeight = function( )
      return 1024
    end
    assert.are.equals( 768, d:getMeta( d.data[1] ) )
  end)
end)

describe( "calculation functions", function( )
  it( "detects function calls", function( )
    local d = MetaJSON
    assert.is_true( d.isCall( "add()" ) )
  end)

  it( "handles MetaJSON key calc", function( )
    local d = MetaJSON{ json = [[
      {
        "calc" : [ 5, 10, "add()", 7, 2, "sub()", "div()" ]
      }
    ]] }
    assert.are.equals( 3, d:getMeta( d.data ) )
  end)

  it( "works with extra calculation functions", function( )
    local d = MetaJSON{ json = [[
      {
        "calc" : [ "screenHeight()", 2, "div()" ]
      }
    ]] }
    function d.screenHeight( )
      return 1024
    end
    function d.calc:screenHeight( )
      self:push( d.screenHeight( ) )
      return
    end
    assert.are.equals( d.screenHeight( ) / 2, d:getMeta( d.data ) )
  end)
end)
