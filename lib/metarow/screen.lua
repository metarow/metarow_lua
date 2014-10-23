local screen = { }

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
