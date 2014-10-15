require"specs.spec_helper"

describe( "basic functions", function( )
  before_each(function( )
    display.cleanStage( )
  end)

  it( "provides screen coordinates", function( )
    assert.are.equals( application.content.width, display.pixelWidth )
    assert.are.equals( application.content.height, display.pixelHeight )
    assert.are.equals( application.content.width, display.contentWidth )
    assert.are.equals( application.content.height, display.contentHeight )
  end)

  it( "holds a global StageObject", function( )
    assert.is_not_nil( display.currentStage )
    assert.are.equals( 0, display.currentStage.numChildren )
  end)

  it( "can draw rectangles on current stage", function( )
    local rect = display.newRect( 0, 0, 50, 100 )
    assert.are.equals( 0, rect.x )
    assert.are.equals( 100, rect.path.height )
    assert.are.equals( "rect", rect.path.type )
    assert.are.equals( "solid", rect.fill.type )
    assert.are.equals( 1, display.currentStage.numChildren )
  end)

  it( "can insert rectangles in a group", function( )
    local group = display.newGroup( )
    local rect = display.newRect( group, 0, 0, 50, 100 )
    assert.are.equals( 1, group.numChildren )
    assert.are.equals( 1, display.currentStage.numChildren )
  end)
  it( "can draw text objects on current stage", function( )
    local options = {
      text = "Hello world!",
      x = 100,
      y = 200,
      font = "Arial",
      fontSize = 32,
    }
    local text = display.newText( options )
    assert.are.equals( "Hello world!", text.text )
    assert.are.equals( 100, text.x )
    assert.are.equals( "Arial", text.font )
    assert.are.equals( 32, text.size )
    assert.are.equals( 1, display.currentStage.numChildren )
  end)
end)
