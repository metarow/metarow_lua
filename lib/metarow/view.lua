--- View Module.
-- defines the available view functions
-- inherit from MetaJSON
-- @module view
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local widget = require"widget"

local MetaJSON = require"lib.metarow.MetaJSON"
local view = MetaJSON( )

local group = display.newGroup()
local templateName = "default"

--- create a ShapeObject
-- @tparams table params options for the display object
-- @treturn ShapeObject
function view.createRect( params )
  local rect = display.newRect(
    params.x, params.y, params.width, params.height
  )
  rect:setFillColor( unpack( params.fillColor or { 1 } ) )
  rect.anchorX = params.anchorX
  rect.anchorY = params.anchorY
  return rect
end

--- create a DisplayObject
-- @tparams table params options for the display object
-- @treturn DisplayObject
function view.createText( params )
  local text = display.newText( params )
  text:setFillColor( unpack( params.fillColor or { 1 } ) )
  text.anchorX = params.anchorX
  text.anchorY = params.anchorY
  return text
end

--- create a ButtonObject
-- @tparams table params options for the button object
-- @treturn ButtonObject
function view.createButton( params )
  return {}
end

--- handles row render event
-- creates text objects for database field content
-- @tparams table params options
local function onRowRender( event )
  local row = event.row
  local content = { }
  local x = 0
  local index = 0
  local position = 0
  for i, field in ipairs( row.params.fields ) do
    local halfWidth = field.size * row.width * 0.5
    position = position + halfWidth
    local options = {
      parent = row,
      text = row.params.content[field.name],
      x = position,
      y = row.height * 0.5,
      font = native.systemFont,
      fontSize = 24
    }
    content[field.name] = display.newText( options )
    content[field.name]:setFillColor( 0.3 )
    position = position + halfWidth
  end
end

local function onRowTouch( event )
  -- body
end

local function scrollListener( event )
  -- body
end

function view.createTableView( params )
  local tableView = widget.newTableView{
    backgroundColor = params.backgroundColor,
    id = params.id,
    left = params.x,
    top = params.y,
    width = params.width,
    height = params.height,
    noLines = true,
    onRowRender = onRowRender,
    onRowTouch = onRowTouch,
    listener = scrollListener
  }

  local data = metarow.sources[params.id]( )
  for _, row in ipairs( data ) do
    tableView:insertRow{
      rowHeight = params.rowHeight,
      rowColor = params.rowColor,
      params = { content = row, fields = params.fields }
    }
  end
  return tableView
end

--- get the screen width
-- @treturn integer from display.contentWidth
function view.screenWidth( )
  return display.contentWidth
end

--- get the screen height
-- @treturn integer from display.contentHeight
function view.screenHeight( )
  return display.contentHeight
end

--- get the tabbar heigth
-- @treturn integer from metarow.tabBar.height
function view.tabBarHeight( )
  return metarow.tabBar.height
end

--- wrapper for rpn calculation
-- @treturn integer from view.screenWidth
function view.calc:screenWidth( )
  self:push( view.screenWidth( ) )
end

--- wrapper for rpn calculation
-- @treturn integer from view.screenHeight
function view.calc:screenHeight( )
  self:push( view.screenHeight( ) )
end

--- wrapper for rpn calculation
-- @treturn integer from view.tabBarHeight
function view.calc:tabBarHeight( )
  self:push( view.tabBarHeight( ) )
end

--- set the template name
-- overwrite the default template by a view definition
-- @tparams table params from MetaJSON string
function view.setTemplate( params )
  templateName = params.template
end

--- execute the view definition
-- is called by screen.loadScene
-- @treturn list of GroupObject with display objects and the template name
function view:exec(  )
  local group = display.newGroup()
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then
      group:insert( object )
    end
  end
  return group, templateName
end

return view
