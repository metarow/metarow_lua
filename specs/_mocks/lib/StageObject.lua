--- Stage Object Class.
-- It holds the current stage.
-- Currently, Corona has a single global stage instance.
-- @classmod StageObject
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local simple = require 'lib.loop.simple'

local StageObject = simple.class{ __super = GroupObject }

return StageObject
