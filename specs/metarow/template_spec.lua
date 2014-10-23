require"specs.spec_helper"

local template = require"lib.metarow.template"
local f = io.open( 'specs/metarow/template_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.is_true( type( template.createTabBar ) == "function" )
  end)

    it( "loops through meta definition", function( )
      template:setData( jsonString )
      local group = template:exec( )
      assert.are.equals( 1, group.numChildren )
      assert.are.equals( 0, group.__items[1].left )
      assert.are.equals(
        display.contentHeight - metarow.tabBar.height, group.__items[1].top
      )
      assert.are.equals( display.contentWidth, group.__items[1].width )
      assert.are.equals( metarow.tabBar.height, group.__items[1].height )
      assert.are.equals( 'english', group.__items[1].buttons[1].id )
      assert.are.equals( 'deutsch', group.__items[1].buttons[2].id )
      assert.is_true( group.__items[1].buttons[1].selected )
      assert.is_nil( group.__items[1].buttons[2].selected )
      assert.is_true( type( group.__items[1].buttons[1].onPress ) == 'function' )
    end)
end)
