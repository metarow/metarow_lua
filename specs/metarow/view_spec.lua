require"specs.spec_helper"

local view = require"lib.metarow.view"
local f = io.open( 'specs/metarow/view_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "sets functions", function( )
    assert.are.equals( "function", type( view.fun.createRect ) )
    assert.are.equals( "function", type( view.fun.createButton ) )
  end)
  it( "loops through meta definition", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals (3, group.numChildren )
    assert.are.equals ("inventory", templateName )
  end)
end)
