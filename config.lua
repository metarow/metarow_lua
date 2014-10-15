application = {
	content = {
		width = 320,
		height = 320 * display.pixelHeight / display.pixelWidth,
		scale = "letterbox",
		fps = 30,

		--[[
        imageSuffix = {
		    ["@2x"] = 2,
		}
		--]]
	},

    --[[
    -- Push notifications

    notification =
    {
        iphone =
        {
            types =
            {
                "badge", "sound", "alert", "newsstand"
            }
        }
    }
    --]]
}
