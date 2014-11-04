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

-- simulate userdata as table
system.ResourceDirectory = { lfs.currentdir() }
system.DocumentsDirectory = { system.ResourceDirectory[1] .. "/test/Documents" }
system.TemporaryDirectory = { system.ResourceDirectory[1] .. "/test/tmp" }

system.pathForFile = function( file, base )
  if not file then
    return base[1]
  else
    local path
    if base then
      path = base[1]
    else
      path = system.ResourceDirectory[1]
    end
    local pathSource = path .. "/" .. file
    local isDocument = string.find( path, system.DocumentsDirectory[1] )
    if isDocument or io.open( pathSource, "r" ) then
      return pathSource
    else
      return nil
    end
  end
end

if not folderExists( system.DocumentsDirectory[1] ) then
  os.execute( "mkdir -p " .. system.DocumentsDirectory[1] )
end

if not folderExists( system.TemporaryDirectory[1] ) then
  os.execute( "mkdir -p " .. system.TemporaryDirectory[1] )
end
