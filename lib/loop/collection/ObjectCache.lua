--- LOOP Class Library.
-- Cache of Objects Created on Demand
-- @module simple
-- @author Renato Maia <maia@inf.puc-rio.br>
-- (basic implementation)
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>
-- (new way module creation, ldoc style comments)
-- @usage Storage of keys 'retrieve' and 'default' are not allowed.

local oo = require 'lib.loop.base'
local ObjectCache = oo.class( )

ObjectCache.__mode = "k"

--- Metametod if access an absent field in the cache.
-- Uses the method retrieve of the instance to retrieve the value requested.
-- Alternatively, it uses the value of field default as the value requested.
-- @param key
-- @return a table that acts as class

function ObjectCache:__index( key )
  if key ~= nil then
    local value = rawget( self, "retrieve" )
    if value then
      value = value( self, key )
    else
      value = rawget( self, "default" )
    end
    rawset( self, key, value )
    return value
  end
end

return ObjectCache
