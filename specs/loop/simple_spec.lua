local simple = require"lib.loop.simple"
local base = require"lib.loop.base"

describe( "basic functions", function( )
  it( "copies all inherit functions from base", function( )
    assert.is_not_nil( simple.initclass )
    assert.are.equals( "function", type( simple.initclass ) )
  end)

  it( "checks witch LOOP model", function( )
    local Class1 = simple.class( )
    assert.is_true( simple.isclass( Class1 ))
    assert.is_true( base.isclass( Class1 ))
    local Class2 = simple.class{ __super=Class1 }
    assert.is_true( simple.isclass( Class2 ))
    assert.is_false( base.isclass( Class2 ))
  end)

  it( "can determine its parent or child", function( )
    local Class1 = simple.class( )
    local Head = simple.class( )
    local Class2 = simple.class{ __super=Class1 }
    assert.are.equals( Class1, simple.superclass( Class2 ) )
    assert.is_true( simple.subclassof( Class2, Class1 ) )
    assert.is_false( simple.subclassof( Class2, Head ) )
  end)

  it( "creates instances", function( )
    local Class1 = simple.class( )
    local Class2 = simple.class( )
    local object = Class1( )
    assert.is_true( simple.instanceof( object, Class1 ))
    assert.is_false( simple.instanceof( object, Class2 ))
  end)

  it( "defines classes with simple inheritance", function( )
    local Class1 = simple.class( )
    function Class1:__init( args )
      args = args or { }
      local attribs = { }
      attribs.attr1 = args.attr1 or 'value1'
      return attribs
    end
    function Class1:getAttr1( )
      return self.attr1
    end
    local Class2 = simple.class{ __super=Class1 }
    function Class2:__init( args )
      args = args or { }
      local attribs = { }
      attribs.attr2 = args.attr2 or 'value2'
      return attribs
    end
    function Class2:getAttr2( )
      return self.attr2
    end
    local Class3 = simple.class{ __super=Class2 }
    function Class3:__init( args )
      args = args or { }
      local attribs = { }
      attribs.attr3 = args.attr3 or 'value3'
      return attribs
    end
    function Class3:getAttr3( )
      return self.attr3
    end
    local obj = Class3( )
    assert.are.equals( 'value1', obj:getAttr1( ) )
    assert.are.equals( 'value2', obj:getAttr2( ) )
    assert.are.equals( 'value3', obj:getAttr3( ) )
  end)

end)
