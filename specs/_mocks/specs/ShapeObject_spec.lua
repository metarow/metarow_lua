require"specs.spec_helper"
local simple = require"lib.loop.simple"


describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = ShapeObject( )
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, ShapeObject ) )
    assert.is_true( simple.subclassof( ShapeObject, DisplayObject ) )
  end)
  it( "sets the fill color", function( )
    local obj1 = ShapeObject( )
    obj1:setFillColor( 0.5 )
    assert.are.equals( "solid", obj1.fill.type )
    assert.are.equals( 0.5, obj1.fill.green )
    assert.are.equals( 1, obj1.fill.alpha )
    local obj2 = ShapeObject( )
    obj2:setFillColor( 0.1, 0.2, 0.3, 0.4 )
    assert.are.equals( "solid", obj2.fill.type )
    assert.are.equals( 0.2, obj2.fill.green )
    assert.are.equals( 0.4, obj2.fill.alpha )
  end)
end)
