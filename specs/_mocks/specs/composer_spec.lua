require"specs.spec_helper"
local composer = require"specs._mocks.lib.composer"

describe( "basic functions", function( )
  it( "can transition to a scene", function( )
    assert.are.equals( "function", type( composer.gotoScene ) )
  end)
end)
