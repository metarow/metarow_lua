local oo = require 'lib.loop.base'

display = { }

display.currentStage = StageObject( )

display.pixelWidth, display.pixelHeight = setModel( 'iphone' )

require"config"

display.contentWidth = application.content.width
display.contentHeight = application.content.height

function display.newGroup( )
  return GroupObject()
end

function display.newRect( arg1, arg2, arg3, arg4, arg5 )
  local args = { arg1, arg2, arg3, arg4, arg5 }
  local parent = nil
  if #args == 5 then
    parent = args[1]
    table.remove( args, 1 )
  end
  local width = args[3]
  local height = args[4]
  local origin = 0.5
  local rect = ShapeObject{
    x = args[1],
    y = args[2],
    path = {
      type = "rect",
      width = width,
      height = height
    },
    anchorX = origin,
    anchorY = origin,
  }
  if parent then
    parent:insert( rect )
  end
  display.currentStage:insert( rect )
  return rect
end

function display.cleanStage( )
  display.currentStage = StageObject( )
end
