require"specs.spec_helper"

local simple = require"lib.loop.simple"
local Stack = require"lib.metarow.Stack"

local controller = require"lib.metarow.controller"

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.is_true( type( controller.display ) == "function" )
    assert.is_true( type( controller.source ) == "function" )
  end)
end)

describe( "works with table source", function( )
  local f = io.open( 'specs/metarow/controller_string_01.json', "r" )
  local jsonString = f:read( "*a" )
  it( "works with a stack", function( )
    assert.is_true( simple.instanceof( controller.stack, Stack ))
    assert.is_true(controller.stack:empty( ) )
    controller:setData( jsonString )
    controller:exec( )
    assert.is_true(controller.stack:empty( ) )
  end)

  it( "loops through meta definition", function( )
    controller:setData( jsonString )
    local view = controller:exec( )
    assert.is_true( type( metarow.sources["categories"] ) == "function" )
    local data = metarow.sources["categories"]( )
    assert.are.equals( 1, data[1].ID )
    assert.are.equals( "paintings", data[2].name )
  end)

  describe( "works with database source", function( )
    local objectsTableString = [[
      CREATE TABLE objects (
        id INTEGER NOT NULL,
        name TEXT NOT NULL,
        category INTEGER NOT NULL
      );
      INSERT INTO objects VALUES ( 1, 'chair', 1);
      INSERT INTO objects VALUES ( 2, 'Girl Before a Mirror', 2);
    ]]
    local MetaMan = require"lib.metarow.MetaMan"
    _root = MetaMan( )
    _root.handle:exec( objectsTableString )
    local f = io.open( 'specs/metarow/controller_string_02.json', "r" )
    local jsonString = f:read( "*a" )

    it( "loops through meta definition", function( )
      controller:setData( jsonString )
      assert.are.equals( 'model', controller.data[1].fun.params.type.val )
      local view = controller:exec( )
      assert.is_true( type( metarow.sources["objects"] ) == "function" )
      local data = metarow.sources["objects"]( )
      assert.are.equals( 1, data[1].id )
      assert.are.equals( "Girl Before a Mirror", data[2].name )
    end)

  end)
end)
