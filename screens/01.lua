local screenName = "screens.01"

local composer = require "composer"
local screen = require"lib.metarow.screen"

local scene = composer.newScene()

-- local forward references should go here


-- functions should go here


function scene:create( event )
  local sceneGroup = self.view
  sceneGroup:insert( screen.loadScene( screenName, event ) )
end

function scene:show( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

function scene:hide( event )
  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then

  elseif ( phase == "did" ) then

  end
end

function scene:destroy( event )
  local sceneGroup = self.view
end

-- -------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -------------------------------------------------------------------------------

return scene
