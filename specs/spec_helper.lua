--spec_helper.lua
inspect = require"inspect"
local oo = require 'lib.loop.base'

local lfs = require"lfs"

function folderExists(strFolderName)
  if lfs.attributes(strFolderName:gsub("\\$",""),"mode") == "directory" then
    return true
  else
    return false
  end
end

system = {}
system.pathForFile = function( file, path )
  local pathSource = path .. "/" .. file
  local isDocument = string.find( path, system.DocumentsDirectory )
  if isDocument or io.open( pathSource, "r" ) then
    return pathSource
  else
    return nil
  end
end
system.getInfo = function( propertyName )
  local properties = {
    appName = "MetaRow",
    environment = "test"
  }
  return properties[propertyName]
end
system.DocumentsDirectory = "/tmp/" .. system.getInfo( "appName" ) .. "/Documents"
system.ResourceDirectory = lfs.currentdir()

if not folderExists( system.DocumentsDirectory ) then
  os.execute( "mkdir -p " .. system.DocumentsDirectory )
end

display = {}
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

