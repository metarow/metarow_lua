--- TableViewWidget Class.
-- Display a tableView in the content area.
-- @classmod TableViewWidget
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local TableViewWidget = simple.class{ __super = EventListener }

function TableViewWidget:__init( args )
  args = args or { }
  local attrs = args
  attrs.rows = { }
  return attrs
end

function TableViewWidget:insertRow( options )
  local index = #self.rows + 1
  self.rows[index] = GroupObject( )
  --workaround, no events, direct call
  local event = { }
  event.row = self.rows[index]
  event.row.index = index
  event.row.width = self.width
  event.row.height = options.rowHeight or 50
  event.row.params = options.params
  self.onRowRender( event )
end

return TableViewWidget
