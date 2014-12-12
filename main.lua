-- include metarow defaults
metarow = require"metarow"

local MetaMan = require"lib.metarow.MetaMan"

metarow.root = MetaMan{ solutionName=metarow.defaultSolution }
metarow.root:loadAllModels()

metarow.root:call( 'objects' )
