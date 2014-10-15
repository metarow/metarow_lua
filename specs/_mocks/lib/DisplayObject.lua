--- Display Object Class.
-- Basic functions.
-- @classmod DisplayObject
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local DisplayObject = simple.class{ __super = EventListener }

return DisplayObject
