--- Stack Class.
-- Implements a LIFO queue.
-- @classmod Stack
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local oo = require 'lib.loop.base'
local Stack = oo.class( )

function Stack:__init( )
  local attrs = { }
  attrs.__et = { }
  return attrs
end

function Stack:empty( )
  return #self.__et == 0
end

function Stack:push( entry )
  self.__et[#self.__et + 1] = entry
end

function Stack:number( )
  return #self.__et
end

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
