-- include metarow defaults
metarow = require"metarow"

local MetaMan = require"lib.metarow.MetaMan"

local root = MetaMan{ solutionName=metarow.defaultSolution }

root:call( 'index' )
