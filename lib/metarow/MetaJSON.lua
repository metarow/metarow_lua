--- MetaJSON Handler Class.
-- Implements the JSON meta level.
-- Loops through a meta definition and interpretes the keywords:
-- fun = functions declared by the model, view and controller modules
-- val = a direct value
-- calc = a value defined by a RPN calculation
-- @classmod MetaJSON
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local calc = require"lib.metarow.calculator"

local oo = require 'lib.loop.base'
local MetaJSON = oo.class( )

--- helper function that checks a call
-- ends a string with a ()
-- @tparam string value
-- @treturn boolean true if a RPN function call
function MetaJSON.isCall( value )
  return value:sub( -2, -1 ) == "()"
end

local json = require "json"

--- create a meta json object
-- instances of MetaJSON
-- @tparam table args args.json initial json string
-- @treturn MetaJSON interpreter object
function MetaJSON:__init( args )
  args = args or { }
  local attribs = { }
  attribs.data = json.decode( args.json or '{ }' ) or { }
  attribs.calc = calc
  return attribs
end

--- set the data property
-- decodes a valid JSON string
-- @tparam string jsonString with the data
-- @return nothing
function MetaJSON:setData( jsonString )
  self.data = json.decode( jsonString ) or { }
end

--- interpretes a single meta key
-- works recursive, params can include all meta keys
-- @tparam table node meta definitions
-- @treturn result from meta definition
function MetaJSON:getMeta( node )
  if node.val then
    return node.val
  elseif node.fun then
    local params = {}
    if node.fun.params then
      params = self:getParams( node.fun )
    end
    return self[node.fun.name]( params )
  elseif node.calc then
    local entries = node.calc
    for _, entry in ipairs( entries ) do
      if type( entry ) == "string" and MetaJSON.isCall( entry ) then
        entry = entry:sub( 1, -3 )
        self.calc[entry]( self.calc )
      else
        self.calc:push( entry )
      end
    end
    return self.calc:pop( )
  end
end

--- loops through a params table
-- all params must defined as key value pairs
-- @tparam table node definition
-- @treturn table parameter values
function MetaJSON:getParams( node )
  local params = {}
  for k,v in pairs( node.params ) do
    params[k] = self:getMeta( v )
  end
  return params
end

return MetaJSON
