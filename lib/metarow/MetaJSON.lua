local oo = require 'lib.loop.base'
local MetaJSON = oo.class( )

local json = require "json"

function MetaJSON:__init( args )
  args = args or { }
  local attribs = { }
  attribs.data = json.decode( args.json or '{ }' )
  return attribs
end

function MetaJSON:setData( jsonString )
  self.data = json.decode( jsonString or '{ }' )
end

function MetaJSON:getMeta( node )
  if node.val then
    return node.val
  elseif node.fun then
    local params = {}
    if node.fun.params then
      for k,v in pairs( node.fun.params ) do
        params[k] = self:getMeta( v )
      end
    end
    return self[node.fun.name]( params )
  end
end

function MetaJSON:getParams( node )
  local params = {}
  for k,v in pairs( node.params ) do
    params[k] = self:getMeta( v )
  end
  return params
end

return MetaJSON
