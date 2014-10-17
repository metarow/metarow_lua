local MetaMan = require"lib.metarow.MetaMan"

local solutionName = "inventory"
local root = MetaMan{ solutionName=solutionName }

root.view:setData( root:getDefinition( 'view', 'index' ) )

local group, templateName = root.view:exec( )
