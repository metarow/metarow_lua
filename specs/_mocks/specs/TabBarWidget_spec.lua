require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = TabBarWidget( )
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, TabBarWidget ) )
    assert.is_true( simple.subclassof( TabBarWidget, EventListener ) )
  end)
end)
