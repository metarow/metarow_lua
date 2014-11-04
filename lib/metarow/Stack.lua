--- Stack Class.
-- Implements a LIFO queue.
-- @classmod Stack
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local oo = require 'lib.loop.base'
local Stack = oo.class( )

--- init a stack
-- __et holds the elements
-- @treturn Stack instance
function Stack:__init( )
  local attrs = { }
  attrs.__et = { }
  return attrs
end

--- test if stack empty
-- @treturn boolean true if no entry on stack
function Stack:empty( )
  return #self.__et == 0
end

--- push an entry on top of the stack
-- @param entry to store
-- @return nothing
function Stack:push( entry )
  self.__et[#self.__et + 1] = entry
end

--- count the number of entries
-- @treturn integer number of entries
function Stack:number( )
  return #self.__et
end

--- pop entries from top of the stack
-- @tparam integer count number of entries
-- @return a list of entries
function Stack:pop( count )
  count = count or 1
  if self:number() < count then return nil end
  local entries = {}
  for i = 1, count do
    entries[i] = table.remove( self.__et )
  end
  return unpack( entries )
end

return Stack
