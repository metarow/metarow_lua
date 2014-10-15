require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = DisplayObject( )
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, DisplayObject ) )
    assert.is_true( simple.subclassof( DisplayObject, EventListener ) )
  end)
end)
