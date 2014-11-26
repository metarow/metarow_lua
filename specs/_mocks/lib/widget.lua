local widget = { }

function widget.newTabBar( args )
  local tabBarWidget = TabBarWidget( args )
  display.currentStage:insert( tabBarWidget )
  return tabBarWidget
end

function widget.newTableView( args )
  local tableViewWidget = TableViewWidget( args )
  display.currentStage:insert( tableViewWidget )
  return tableViewWidget
end

return widget
