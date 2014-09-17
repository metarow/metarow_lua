local oo = require 'lib.loop.base'

local display = {}
display.groups = {}

display.GroupObject = oo.class( )

function display.GroupObject:__init(  )
  return oo.rawnew( self, { objects = { } , numChildren = 0} )
end

function display.GroupObject:insert( object )
  self.objects[#self.objects+1] = object
  self.numChildren = self.numChildren + 1
end

function display.newGroup( )
  return display.GroupObject( )
end

return display
