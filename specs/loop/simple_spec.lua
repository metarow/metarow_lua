local simple = require"lib.loop.simple"
local base = require"lib.loop.base"

describe( "basic functions", function( )
  it( "copies all inherit functions from base", function( )
    assert.is_not_nil( simple.initclass )
    assert.are.equals( "function", type( simple.initclass ) )
  end)

  it( "checks witch LOOP model", function( )
    local Root = simple.class( )
    assert.is_true( simple.isclass( Root ))
    assert.is_true( base.isclass( Root ))
    local Tree = simple.class( {}, Root)
    assert.is_true( simple.isclass( Tree ))
    assert.is_false( base.isclass( Tree ))
  end)

  it( "can determine its parent or child", function( )
    local Root = simple.class( )
    local Head = simple.class( )
    local Tree = simple.class( {}, Root)
    assert.are.equals( Root, simple.superclass( Tree ) )
    assert.is_true( simple.subclassof( Tree, Root ) )
    assert.is_false( simple.subclassof( Tree, Head ) )
  end)

  it( "creates instances", function( )
    local Class1 = simple.class( )
    local Class2 = simple.class( )
    local object = Class1( )
    assert.is_true( simple.instanceof( object, Class1 ))
    assert.is_false( simple.instanceof( object, Class2 ))
  end)

  it( "defines classes with simple inheritance", function( )
    local Root = simple.class( )
    function Root:__init( )
      return simple.rawnew( self, { status = 'old' } )
    end
    function Root:getStatus( )
      return self.status
    end
    local Tree = simple.class( {}, Root)
    function Tree:__init( )
      return simple.rawnew( self, { count = 10, status = 'old' } )
    end
    function Tree:getCount( )
      return self.count
    end
    local obj = Tree( )
    assert.are.equals( 'old', obj:getStatus( ) )
    assert.are.equals( 10, obj:getCount( ) )
  end)

end)
