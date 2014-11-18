require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = TabBarWidget( )
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, TabBarWidget ) )
    assert.is_true( simple.subclassof( TabBarWidget, EventListener ) )
  end)

  it( "processes all options", function( )
    local options = {
      width = 320
    }
    local object = TabBarWidget( options )
    assert.are.equals( 320, object.width )
  end)
end)
