--- Event Listener Class.
-- Objects can receive events.
-- @classmod EventListener
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local EventListener = simple.class{ __super = Object }

--- add an event listener
-- does nothing for now
-- @tparam string eventName
-- @tparam function listener handle the event
-- @return none
function EventListener:addEventListener( eventName, listener )
end

return EventListener
