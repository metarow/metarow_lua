local Stack = require"lib.metarow.Stack"

local oo = require 'lib.loop.base'
local MetaJSON = oo.class( )

function MetaJSON.isCall( value )
  return value:sub( -2, -1 ) == "()"
end

function add( a, b )
  return a + b
end

--TODO add the rest of arithmetic

local json = require "json"

function MetaJSON:__init( args )
  args = args or { }
  local attribs = { }
  attribs.data = json.decode( args.json or '{ }' )
  attribs.calc = Stack( )
  attribs.calc.add = { fun=add, par=2 }
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
  elseif node.calc then
    local entries = node.calc
    local params = { }
    for _, entry in ipairs( entries ) do
      if type( entry ) == "string" and MetaJSON.isCall( entry ) then
        entry = entry:sub( 1, -3 )
        for i = self.calc[entry].par, 1, -1 do
          params[i] = self.calc:pop( )
        end
        self.calc:push( self.calc[entry].fun( unpack( params ) ) )
        params = { }
      else
        self.calc:push( entry )
      end
    end
    return self.calc:pop( )
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
