--- Controller Module.
-- defines the available controller functions
-- inherit from MetaJSON
-- @module controller
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local MetaJSON = require"lib.metarow.MetaJSON"
local controller = MetaJSON( )

local Stack = require"lib.metarow.Stack"
controller.stack = Stack( )


--- display a view
-- this function is at the end of a controller definition
-- @tparam table params from JSON string
-- @treturn string name of the view, which is to be displayed
function controller.display( params )
  return params.view
end

--- set the data source for a view
-- create and store a closure in the metarow namespace
-- @tparam table params from JSON string
-- @treturn function name of the view, which is to be displayed
function controller.source( params )
  local type = params.type
  local name = params.name
  if type == "table" then
    local data = controller.stack:pop( )
    metarow.sources[name] = function( )
      return data
    end
  elseif type == "model" then
    --local model = controller.stack:pop( )
    metarow.sources[name] = function( )
      local data = { }
      for row in _root.handle:nrows( ( "SELECT * FROM %s" ):format( name ) ) do
        data[#data+1] = { id=row.id, name=row.name, category=row.catagory }
      end
      return data
    end
  end
end

--- execute the controller definition
-- is called by MetaMan:call
-- @treturn string name of the view definition
function controller:exec(  )
  for i, element in ipairs( self.data ) do
    local result = self:getMeta( element )
    if result then controller.stack:push( result ) end
  end
  return controller.stack:pop( )
end

return controller
