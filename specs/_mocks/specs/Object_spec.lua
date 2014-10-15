require"specs.spec_helper"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local obj = Object()
    assert.is_not_nil( obj )
  end)
end)
