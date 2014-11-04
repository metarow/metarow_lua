--- Controller Module.
-- defines the available controller functions
-- inherit from MetaJSON
-- @module controller
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local MetaJSON = require"lib.metarow.MetaJSON"
local controller = MetaJSON( )

--- display a view
-- this function is at the end of a controller definition
-- @tparam table params from JSON string
-- @treturn string name of the view, which is to be displayed
function controller.display( params )
  return params.view
end

--- execute the controller definition
-- is called by MetaMan:call
-- @treturn string name of the view definition
function controller:exec(  )
  local view
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then view = object end
  end
  return view
end

return controller
