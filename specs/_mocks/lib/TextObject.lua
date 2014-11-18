--- Text Object Class.
-- hold data for texts.
-- @classmod TextObject
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local TextObject = simple.class{ __super = DisplayObject }

function TextObject:__init( args )
  local attrs = table.copy( args or { }, { } )
  attrs.size = attrs.fontSize or 13
  attrs.fontSize = nil
  attrs.fill = { }
  return attrs
end

--- sets the fill color for text objects
-- mixin from ShapeObject
TextObject.setFillColor = ShapeObject.setFillColor

return TextObject
