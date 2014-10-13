require"specs.spec_helper"

local view = require"lib.metarow.view"
local f = io.open( 'specs/metarow/view_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.are.equals( "function", type( view.createRect ) )
    assert.are.equals( "function", type( view.createButton ) )
  end)

  it( "loops through meta definition", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( 3, group.numChildren )
    assert.are.equals( "inventory", templateName )
    assert.are.equals( 0, group.__items[1].x)
    assert.are.equals( 0, group.__items[1].y)
    assert.are.equals( 320, group.__items[1].path.width)
  end)
end)
