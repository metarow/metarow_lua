require"specs.spec_helper"
local widget = require"specs._mocks.lib.widget"

describe( "basic functions", function( )
  it( "can draw tabBars on current stage", function( )
    local tabBar = widget.newTabBar()
    assert.are.equals( "function", type( widget.newTabBar ) )
  end)
end)
