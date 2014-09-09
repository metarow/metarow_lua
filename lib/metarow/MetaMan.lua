--- MetaRow Manager Class.
-- Root Class for MetaRow specification.
-- Controls a solution formed with MetaJSON embedded in the table _MetaRow
-- @classmod MetaMan
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

function copy( resource, document )
  local inFile = io.open( resource, "r" )
  local outFile  = io.open( document, "w" )
  local contents = inFile:read( "*a" )
  outFile:write( contents )
  io.close( inFile )
  io.close( outFile )
end

if system.getInfo"environment" =='test' then
  local sqlite3 = require "lsqlite3"
else
  local sqlite3 = require "sqlite3"
end

local base = require 'lib.loop.base'
local MetaMan = base.class( )

--- create a solution object
-- instances of MetaMan can drive a MetaJSON based solution
-- @tparam string solutionName solution to be open
-- @treturn MetaMan the initalized MetaRow Manager
function MetaMan:__init( solutionName )
  local resourcePath = system.pathForFile(
    "data/" .. solutionName .. ".sqlite", system.ResourceDirectory
  )
  local documentPath = system.pathForFile(
    solutionName .. ".sqlite", system.DocumentsDirectory
  )
  if io.open( documentPath, "r" ) then
    --TODO check _MetaRow version
  else
    if not resourcePath then return nil end
    copy( resourcePath, documentPath )
  end
  local handle = sqlite3.open( documentPath )
  return base.rawnew( self, {
      handle = handle
  })
end

return MetaMan
