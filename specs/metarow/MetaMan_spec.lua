require"specs.spec_helper"

local MetaMan = require"lib.metarow.MetaMan"

describe( "basic functions", function( )
  it( "looks for a solution database", function( )
    local solutionName = "inventory"
    local root = MetaMan( solutionName )
    assert.is_not_nil( root )
    assert.is_not_nil( root.handle )
  end)
end)
