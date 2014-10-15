local MetaJSON = require"lib.metarow.MetaJSON"
local view = MetaJSON( )

local group = display.newGroup()
local templateName = "default"

function view.createRect( params )
  local rect = display.newRect(
    params.x, params.y, params.width, params.height
  )
  rect:setFillColor( unpack( params.fillColor or { } ) or 1 )
  rect.anchorX = params.anchorX
  rect.anchorY = params.anchorY
  return rect
end

function view.createText( params )
  local text = display.newText( params )
  text:setFillColor( unpack( params.fillColor or { } ) or 1 )
  text.anchorX = params.anchorX
  text.anchorY = params.anchorY
  return text
end

function view.createButton( params )
  return {}
end

function view.screenWidth( params )
  return display.contentWidth
end

function view.screenHeight( params )
  return display.contentHeight
end

function view.setTemplate( params )
  templateName = params.template
end

function view:exec(  )
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then group:insert( object ) end
  end
  return group, templateName
end

return view
