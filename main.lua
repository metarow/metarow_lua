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
        "fillColor" : { "val" : [0.6] }
      }
    }
  },
  {
    "fun" : {
      "name" : "createRect",
      "params" : {
        "x" : { "calc" : [ "screenWidth()", 2, "div()" ] },
        "y" : { "calc" : [ "screenHeight()", 2, "div()" ] },
        "anchorX" : { "val" : 0.5 },
        "anchorY" : { "val" : 0.5 },
        "width" :  { "val" : 250 },
        "height" : { "val" : 70 },
        "fillColor" : { "val" : [0.7, 0.5, 0.3] }
      }
    }
  },
  {
    "fun" : {
      "name" : "createText",
      "params" : {
        "text" : { "val" : "Hello world!" },
        "x" : { "calc" : [ "screenWidth()", 2, "div()" ] },
        "y" : { "calc" : [ "screenHeight()", 2, "div()" ] },
        "anchorX" : { "val" : 0.5 },
        "anchorY" : { "val" : 0.5 },
        "fillColor" : { "val" : [0.9] },
        "fontSize" : { "val" : 32 }
      }
    }
  }
]
]]

root.view:setData( jsonString )

local group, templateName = root.view:exec( )

