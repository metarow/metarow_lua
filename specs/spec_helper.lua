--spec_helper.lua
inspect = require"inspect"

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

