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
  local type = event.params.type
  local key = event.params.key
  --TODO set timestamp for purgeScreen
  metarow.root.activeViews[key] = { screenName = screenName }
  metarow.root.view:setData(
    metarow.root:getDefinition( type, key )
  )
  local group, templateName = metarow.root.view:exec( )
  if metarow.root.activeTemplate.name ~= templateName then
    --TODO remove old and display new template
    metarow.root.activeTemplate.name = templateName
    metarow.root.template:setData( metarow.root:getDefinition( 'template', templateName ) )
    metarow.root.activeTemplate.group = metarow.root.template:exec( )
  end
  return group
end

return screen
