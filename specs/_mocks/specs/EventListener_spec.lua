require"specs.spec_helper"
local simple = require"lib.loop.simple"


describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = EventListener()
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, EventListener ) )
    assert.is_true( simple.subclassof( EventListener, Object ) )
  end)
  it( "can add an event listener", function( )
    local object = EventListener()
    object:addEventListener( "touch", function( event )
      return true
    end)
  end)
end)
