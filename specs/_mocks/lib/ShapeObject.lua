--- Vector Object Class.
-- hold data for rectangles, cirles, rounded rectangles and lines.
-- @classmod ShapeObject
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local ShapeObject = simple.class{ __super = DisplayObject }

function ShapeObject:__init( args )
  args = args or { }
  local attrs = args
  attrs.fill = attrs.fill or { type="solid", red=1, green=1, blue=1, alpha=1 }
  return attrs
end

--- sets the fill color of vector and text objects
-- does nothing for now
-- @tparam number arg1 gray scale for single arg, red for min three args
-- @return none
function ShapeObject:setFillColor( arg1, arg2, arg3, arg4 )
  local args = { arg1, arg2, arg3, arg4 }
  if type( arg1 ) == 'number' then
    self.fill.type = "solid"
    self.fill.red = arg1
    if #args < 3 then
      self.fill.green = arg1
      self.fill.blue = arg1
      self.fill.alpha = arg2 or 1
    else
      self.fill.green = arg2
      self.fill.blue = arg3
      self.fill.alpha = arg4 or 1
    end
  end
end

return ShapeObject
