-- include metarow defaults
metarow = require"metarow"

local MetaMan = require"lib.metarow.MetaMan"

_root = MetaMan{ solutionName=metarow.defaultSolution }

_root:call( 'english' )
