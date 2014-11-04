require"specs.spec_helper"

local controller = require"lib.metarow.controller"
local f = io.open( 'specs/metarow/controller_string.json', "r" )
jsonString = f:read( "*a" )

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.is_true( type( controller.display ) == "function" )
  end)

  it( "loops through meta definition", function( )
    controller:setData( jsonString )
    local view = controller:exec( )
    assert.are.equals( 'index', view )
  end)
end)
