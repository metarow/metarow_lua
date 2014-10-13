local MetaJSON = require"lib.metarow.MetaJSON"
local view = MetaJSON( )

local group = display.newGroup()
local templateName = "default"

function createRect( params )
  local rect = display.newRect(
    params.x, params.y, params.width, params.height
  )
  return rect
end

function createButton( params )
  return {}
end

function screenWidth( params )
  return display.contentWidth
end

function screenHeight( params )
  return display.contentHeight
end

function setTemplate( params )
  templateName = params.template
end

view:setFun{
  createRect = createRect,
  createButton = createButton,
  screenWidth = screenWidth,
  screenHeight = screenHeight,
  setTemplate = setTemplate,
}

function view:exec(  )
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then group:insert( object ) end
  end
  return group, templateName
end

return view
