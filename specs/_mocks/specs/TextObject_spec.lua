require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local text = TextObject( )
    assert.is_not_nil( text )
    assert.is_true( simple.instanceof( text, TextObject ) )
    assert.is_true( simple.subclassof( TextObject, DisplayObject ) )
  end)

  it( "inherits properties from DisplayObject", function( )
    local options = {
      x = display.contentWidth / 2,
      y = display.contentHeight / 2
    }
    local text = TextObject( options )
    assert.are.equals( options.x,  text.x )
    assert.are.equals( options.y,  text.y )
  end)

  it( "has setFillColor mixed in from ShapeObject", function( )
    local text = TextObject( )
    assert.are.equals( "function", type( text.setFillColor ) )
  end)

  it( "has text and size properties", function( )
    local options = {
      text = "Hello World!",
      x = display.contentWidth / 2,
      y = display.contentHeight / 2,
      fontSize = 32
    }
    local text = TextObject( options )
    assert.are.equals( options.text,  text.text )
    assert.are.equals( options.fontSize,  text.size )
    assert.is_nil( text.fontSize )
  end)
end)
