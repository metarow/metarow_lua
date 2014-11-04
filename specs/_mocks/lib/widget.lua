local widget = { }

function widget.newTabBar( args )
  local tabBarWidget = TabBarWidget( args )
  display.currentStage:insert( tabBarWidget )
  return tabBarWidget
end

return widget
