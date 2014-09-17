require"specs.spec_helper"
local oo = require"lib.loop.base"

describe( "basic functions", function( )
  it( "provides a GroupObject with constructor", function( )
    assert.is_not_nil( display.GroupObject )
    local object = display.newGroup( )
    assert.is_true( oo.instanceof( object, display.GroupObject ))
  end)
  it( "stores objects as children", function( )
    -- TODO test display.GroupObject:insert
  end)
end)
