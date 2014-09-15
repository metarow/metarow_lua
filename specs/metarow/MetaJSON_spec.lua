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
    assert.are.equal( 0, #d.data )
  end)

  it( "stores parsed JSON data", function( )
    local d = MetaJSON( jsonString )
    assert.is_not_nil( d )
    assert.is_true( type( d.data ) == 'table')
    assert.are.equal( 4, #d.data )
    assert.are.equal( 'createRect', d.data[1].fun.name )
  end)

  it( "sets data from new JSON string", function( )
    local d = MetaJSON()
    d:setData( jsonString )
    assert.is_true( type( d.data ) == 'table')
  end)

  it( "holds an array with functions", function( )
    local d = MetaJSON( jsonString )
    local createRect = function( )
      return 1
    end
    d:setFun{ createRect = createRect }
    assert.is_true( type( d.fun ) == 'table' )
    assert.is_true( type( d.fun['createRect'] ) == 'function' )
    assert.are.equal( 1, d.fun[d.data[1].fun.name]( ) )
  end)

  it( "handles MetaJSON key val", function( )
    local d = MetaJSON( '{ "val" : 1 }' )
    assert.are.equal( 1, d:getMeta( d.data ))
  end)

  it( "parses params key", function( )
    local d = MetaJSON([[
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
    ]])
    d:setFun{
      screenWidth = function( )
        return 768
      end,
      screenHeight = function( )
        return 1024
      end
    }
    local params = d:getParams( d.data )
    assert.are.equal( 2, params.strokeWidth )
    assert.are.equal( 768, params.width)
  end)

  it( "handles MetaJSON key fun", function( )
    local d = MetaJSON( jsonString )
    d:setFun{
      createRect = function( params )
        return params.x
      end,
      screenWidth = function( )
        return 768
      end,
      screenHeight = function( )
        return 1024
      end
    }
    assert.are.equal( 0, d:getMeta( d.data[1]) )
  end)
end)
