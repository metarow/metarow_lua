local base = require"lib.loop.base"

describe( "basic functions", function( )
  it( "provides a class constructor", function( )
    local Class = base.class( )
    assert.is_true( base.isclass( Class ))
    assert.is_false( base.isclass( {} ))
  end)

  it( "creates instances", function( )
    local Class1 = base.class( )
    local object = Class1( )
    assert.is_true( base.instanceof( object, Class1 ))
    local Class2 = base.class( )
    assert.is_false( base.instanceof( object, Class2 ))
  end)

  it( "can instantiate through rawnew", function( )
    local Class = base.class( )
    local object = Class{ val=10 }
    assert.are.equals( 10, object.val )
  end)

  it( "can instantiate through __init", function( )
    local Class = base.class( )
    function Class:__init( val )
      return base.rawnew( self, { val = val } )
    end
    local object = Class( 10 )
    assert.are.equals( 10, object.val )
  end)

  it( "provides functions as members", function( )
    local Class = base.class( )
    function Class:sum( a, b )
      return a + b
    end
    local object = Class( )
    assert.are.equals( object.sum, base.memberof( Class, "sum" ))
    assert.are.equals( 3, object:sum( 1, 2 ))
  end)
end)
