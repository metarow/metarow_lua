require"specs.spec_helper"

local view = require"lib.metarow.view"

describe( "basic functions", function( )
  local f = io.open( 'specs/metarow/view_string_01.json', "r" )
  local jsonString = f:read( "*a" )
  it( "has functions", function( )
    assert.is_true( type( view.createRect ) == "function" )
    assert.is_true( type( view.createButton ) == "function" )
    assert.is_true( type( view.createText ) == "function" )
  end)

  it( "loops through meta definition", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( 3, group.numChildren )
    assert.are.equals( "inventory", templateName )
    assert.are.equals( 0, group.__items[1].x)
    assert.are.equals( 0, group.__items[1].y)
    assert.are.equals( display.contentWidth, group.__items[1].path.width)
    assert.are.equals( 0, group.__items[1].anchorX)
    assert.are.equals( 0, group.__items[1].anchorY)
  end)

  it( "provides screen coordinates for calculations", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( "function", type( view.calc.screenHeight ) )
    assert.are.equals( "function", type( view.calc.screenWidth ) )
    assert.are.equals( display.contentWidth / 2, group.__items[2].x )
    assert.are.equals( display.contentHeight / 2, group.__items[2].y )
  end)

  it( "assigns the color array", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( 0.8, group.__items[2].fill.red )
    assert.are.equals( 0.5, group.__items[2].fill.green )
    assert.are.equals( 0, group.__items[2].fill.blue )
    assert.are.equals( 1, group.__items[2].fill.alpha )
  end)

  it( "provides tabBar height for calculations", function( )
    assert.is_true( type( view.tabBarHeight ) == "function" )
    assert.are.equals( metarow.tabBar.height, view.tabBarHeight( ))
    assert.are.equals( "function", type( view.calc.tabBarHeight ) )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals(
      display.contentHeight - metarow.tabBar.height,
      group.__items[1].path.height
    )
  end)
end)

describe( "work with tableViews", function( )
  local controller = require"lib.metarow.controller"
  local f = io.open( 'specs/metarow/controller_string_01.json', "r" )
  controller:setData( f:read( "*a" ) )
  controller:exec( )

  local f = io.open( 'specs/metarow/view_string_03.json', "r" )
  local jsonString = f:read( "*a" )

  it( "has functions", function( )
    assert.is_true( type( view.createTableView ) == "function" )
  end)

  it( "maps x and y to left and top", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( 0, group.__items[1].left )
    assert.are.equals( 0, group.__items[1].top )
  end)

  it( "sets height and width", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( display.contentWidth, group.__items[1].width )
    assert.are.equals(
      display.contentHeight - metarow.tabBar.height,
      group.__items[1].height
    )
  end)

  it( "has an id and handles event over this id", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    assert.are.equals( "categories", group.__items[1].id )
    assert.is_true( type( group.__items[1].onRowRender ) == 'function' )
    assert.is_true( type( group.__items[1].onRowTouch ) == 'function' )
    assert.is_true( type( group.__items[1].listener ) == 'function' )
  end)

  it( "loads the tableView content from source", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    local tableViewWidth = group.__items[1].width
    local tableViewContent = group.__items[1].rows
    assert.is_not_nil( tableViewContent )
    assert.are.equals( 1, tableViewContent[1].__items[1].text)
    assert.are.equals( 32, tableViewContent[1].__items[1].x )
    assert.are.equals( "paintings", tableViewContent[2].__items[2].text )
    assert.are.equals( 192, tableViewContent[2].__items[2].x )
  end)

  it( "sets the parent object for tableView content", function( )
    view:setData( jsonString )
    local group, templateName = view:exec( )
    local tableViewContent = group.__items[1].rows
    assert.is_not_nil( tableViewContent[1].__items[1].parent )
  end)
end)
