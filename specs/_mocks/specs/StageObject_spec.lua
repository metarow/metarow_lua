require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local grp = StageObject( )
    assert.is_not_nil( grp )
    assert.is_true( simple.instanceof( grp, StageObject ) )
    assert.is_true( simple.subclassof( StageObject, GroupObject ) )
  end)
end)
