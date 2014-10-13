local lfs = require"lfs"

function folderExists(strFolderName)
  if lfs.attributes(strFolderName:gsub("\\$",""),"mode") == "directory" then
    return true
  else
    return false
  end
end

system = {}

system.getInfo = function( propertyName )
  local properties = {
    appName = "MetaRow",
    environment = "test"
  }
  return properties[propertyName]
end

system.DocumentsDirectory = "/tmp/" .. system.getInfo( "appName" ) .. "/Documents"
system.TemporaryDirectory = "/tmp/" .. system.getInfo( "appName" ) .. "/tmp"
system.ResourceDirectory = lfs.currentdir()

system.pathForFile = function( file, base )
  local path = base or system.ResourceDirectory
  local pathSource = path .. "/" .. file
  local isDocument = string.find( path, system.DocumentsDirectory )
  if isDocument or io.open( pathSource, "r" ) then
    return pathSource
  else
    return nil
  end
end

if not folderExists( system.DocumentsDirectory ) then
  os.execute( "mkdir -p " .. system.DocumentsDirectory )
end

if not folderExists( system.TemporaryDirectory ) then
  os.execute( "mkdir -p " .. system.TemporaryDirectory )
end
