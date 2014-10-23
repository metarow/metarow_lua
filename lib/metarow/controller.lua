local MetaJSON = require"lib.metarow.MetaJSON"
local controller = MetaJSON( )

function controller.display( params )
  return params.view
end

function controller:exec(  )
  local view
  for i, element in ipairs( self.data ) do
    local object = self:getMeta( element )
    if object then view = object end
  end
  return view
end

return controller
