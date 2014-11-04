--- Screen Module.
-- connect views to screens
-- @module screen
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local screen = { }

--- load a view definition into a free screen
-- sets also the necessary template
-- @tparam string screenName name of the used screen
-- @tparam Event event fired when a scene initialized
-- @treturn GroupObject with all display objects
function screen.loadScene( screenName, event )
  local root = event.params.root
  local type = event.params.type
  local key = event.params.key
  --TODO set timestamp for purgeScreen
  root.activeViews[key] = { screenName = screenName }
  root.view:setData(
    root:getDefinition( type, key )
  )
  local group, templateName = root.view:exec( )
  if root.activeTemplate.name ~= templateName then
    --TODO remove old and display new template
    root.activeTemplate.name = templateName
    root.template:setData( root:getDefinition( 'template', templateName ) )
    root.activeTemplate.group = root.template:exec( )
  end
  return group
end

return screen
