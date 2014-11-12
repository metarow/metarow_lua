--- TableViewWidget Class.
-- Display a tableView in the content area.
-- @classmod TableViewWidget
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local TableViewWidget = simple.class{ __super = EventListener }

function TableViewWidget:__init( args )
  args = args or { }
  local attrs = args
  return attrs
end

return TableViewWidget
