require"specs.spec_helper"

describe( "basic functions", function( )
  it("has a property systemFont", function( )
    assert.is_not_nil( native.systemFont )
  end)
end)
