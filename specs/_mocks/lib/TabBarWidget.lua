--- TabBarWidget Class.
-- Display a tabBar at the screen bottom.
-- @classmod TabBarWidget
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local TabBarWidget = simple.class{ __super = EventListener }

function TabBarWidget:__init( args )
  args = args or { }
  local attrs = args
  return attrs
end

return TabBarWidget
