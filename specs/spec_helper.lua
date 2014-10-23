--spec_helper.lua
inspect = require"inspect"

-- include metarow defaults
metarow = require"metarow"

setModel = function( model )
  local device = {
    iphone={
      width=320,
      height=480
    },
    ipad={
      width=768,
      height=1024
    },
  }
  local pixelWidth = device[model].width
  local pixelHeight = device[model].height
  return pixelWidth, pixelHeight
end

Object = require"specs._mocks.lib.Object"
EventListener = require"specs._mocks.lib.EventListener"
DisplayObject = require"specs._mocks.lib.DisplayObject"
GroupObject = require"specs._mocks.lib.GroupObject"
StageObject = require"specs._mocks.lib.StageObject"
ShapeObject = require"specs._mocks.lib.ShapeObject"
TextObject = require"specs._mocks.lib.TextObject"
TabBarWidget = require"specs._mocks.lib.TabBarWidget"

require"specs._mocks.lib.system"
require"specs._mocks.lib.display"

package.path = './specs/_mocks/lib/?.lua;' .. package.path
