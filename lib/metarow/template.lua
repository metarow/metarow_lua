local MetaJSON = require"lib.metarow.MetaJSON"

local widget = require"widget"

local template = MetaJSON( )

local group = display.newGroup()

local function handleTabBarEvent( event )
  _root:call( event.target._id )
end

function template.createTabBar( params )
  local left = 0
  local top = display.contentHeight - metarow.tabBar.height
  local width = display.contentWidth
  local height = metarow.tabBar.height
  local buttons = params.buttons
  for i=1,#buttons do
    if i == 1 then buttons[i].selected = true end
    buttons[i].onPress = handleTabBarEvent
    buttons[i].size = metarow.tabBar.buttonSize
    buttons[i].labelYOffset = metarow.tabBar.buttonLabelYOffset
  end
  local tabBar = widget.newTabBar{
    buttons = buttons,
    left=left, top=top, width=width, height=height
  }
  return tabBar
end

function template:exec(  )
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then group:insert( object ) end
  end
  return group
end


return template
