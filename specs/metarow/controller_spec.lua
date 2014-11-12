require"specs.spec_helper"

local simple = require"lib.loop.simple"
local Stack = require"lib.metarow.Stack"

local controller = require"lib.metarow.controller"
local f = io.open( 'specs/metarow/controller_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.is_true( type( controller.display ) == "function" )
    assert.is_true( type( controller.source ) == "function" )
  end)

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
    assert.are.equals( 'categories', view )
    assert.is_true( type( metarow.sources['categories'] ) == "function" )
    local data = metarow.sources['categories']( )
    assert.are.equals( 1, data[1].ID )
    assert.are.equals( "paintings", data[2].name )
  end)
end)
