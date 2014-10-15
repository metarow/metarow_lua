require"specs.spec_helper"

local view = require"lib.metarow.view"
local f = io.open( 'specs/metarow/view_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.are.equals( "function", type( view.createRect ) )
    assert.are.equals( "function", type( view.createButton ) )
    assert.are.equals( "function", type( view.createText ) )
  end)

  it( "loops through meta definition", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( 3, group.numChildren )
    assert.are.equals( "inventory", templateName )
    assert.are.equals( 0, group.__items[1].x)
    assert.are.equals( 0, group.__items[1].y)
    assert.are.equals( display.contentWidth, group.__items[1].path.width)
    assert.are.equals( display.contentHeight, group.__items[1].path.height)
    assert.are.equals( 0, group.__items[1].anchorX)
    assert.are.equals( 0, group.__items[1].anchorY)
  end)

  it( "provides screen coordinates for calculations", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( "function", type( view.calc.screenHeight ) )
    assert.are.equals( "function", type( view.calc.screenWidth ) )
    assert.are.equals( display.contentWidth / 2, group.__items[2].x )
    assert.are.equals( display.contentHeight / 2, group.__items[2].y )
  end)
end)
