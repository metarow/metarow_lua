--- Group Object Class.
-- Basic functions.
-- @classmod GroupObject
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local GroupObject = simple.class{ __super = DisplayObject }

function GroupObject:__init( )
  local attrs = { }
  attrs.__items = { }
  attrs.numChildren = 0
  return attrs
end

--- insert a display object
-- does nothing for now
-- @return none
function GroupObject:insert( object )
  table.insert( self.__items, object )
  self.numChildren = self.numChildren + 1
end


return GroupObject
