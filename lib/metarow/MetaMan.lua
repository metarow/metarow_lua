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

local json = require "json"

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
    local handle_res = sqlite3.open( resourcePath )
    local version_res = MetaMan.getVersion( handle_res )
    local handle_doc = sqlite3.open( documentPath )
    local version_doc = MetaMan.getVersion( handle_doc )
    if version_res > version_doc then
      MetaMan.updateMetaTable( handle_res, handle_doc )
    end
  else
    if not resourcePath then return nil end
    copy( resourcePath, documentPath )
  end
  local handle = sqlite3.open( documentPath )
  local version = MetaMan.getVersion( handle )
  return base.rawnew( self, {
      handle = handle,
      version = version
  })
end

function MetaMan.getVersion( handle )
  local sql = "SELECT value FROM _MetaRow WHERE type='config' AND key='solution'"
  local version
  handle:exec( sql, function ( udata, cols, values, names )
    version = json.decode( values[1] ).version
  end )
  return version
end

function MetaMan.updateMetaTable( handle_res, handle_doc )
  local sql_res = "SELECT type, key, value FROM _MetaRow;"
  handle_doc:exec"DELETE FROM _MetaRow;"
  local stmt = handle_doc:prepare[[
    INSERT INTO _MetaRow (type, key, value)
    VALUES ( :type, :key, :value );
  ]]
  for res in handle_res:nrows( sql_res ) do
    stmt:bind_names{ type=res.type, key=res.key, value=res.value }
    stmt:step()
    stmt:reset()
  end
  handle_doc:close( )
end

return MetaMan
