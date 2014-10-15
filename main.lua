local MetaMan = require"lib.metarow.MetaMan"

local solutionName = "inventory"
local root = MetaMan( solutionName )

local jsonString = [[
[
  {
    "fun" : {
      "name" : "createRect",
      "params" : {
        "x" : { "val" : 0 },
        "y" : { "val" : 0 },
        "anchorX" : { "val" : 0 },
        "anchorY" : { "val" : 0 },
        "width" :  { "fun" : { "name":"screenWidth" }},
        "height" : { "fun" : { "name":"screenHeight" }},
        "fillColor" : { "val" : [0.5,0.5,0.5] }
      }
    }
  }
]
]]

root.view:setData( jsonString )

local group, templateName = root.view:exec( )

