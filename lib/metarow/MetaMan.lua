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

local sqlite3
if system.getInfo"environment" == 'test' then
  sqlite3 = require "lsqlite3"
else
  sqlite3 = require "sqlite3"
end

local json = require "json"

local base = require 'lib.loop.base'
local MetaMan = base.class( )

--- create a solution object
-- instances of MetaMan can drive a MetaJSON based solution
-- @tparam table args args.solutionName defines the solution to be open
-- @treturn MetaMan the initalized MetaRow Manager
function MetaMan:__init( args )
  args = args or { }
  local attribs = { }
  local handle
  local version

  -- for faster testing
  if not args.solutionName then
    attribs.handle = sqlite3.open_memory()
    attribs.version = 0.0
  else
    local resourcePath = system.pathForFile(
      "data/" .. args.solutionName .. ".sqlite", system.ResourceDirectory
    )
    local documentPath = system.pathForFile(
      args.solutionName .. ".sqlite", system.DocumentsDirectory
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
    attribs.handle = sqlite3.open( documentPath )
    attribs.version = MetaMan.getVersion( attribs.handle )
  end

  attribs.view = require"lib.metarow.view"
  attribs.activeViews = { }
  attribs.freeScreens = self:allScreens( )

  attribs.controller = require"lib.metarow.controller"
  attribs.model = require"lib.metarow.model"

  attribs.template = require"lib.metarow.template"
  attribs.activeTemplate = { }
  return attribs
end

--- get the metarow table version
-- read the config solution record
-- @param sqlite handle
-- @return version
function MetaMan.getVersion( handle )
  local sql = "SELECT value FROM _MetaRow WHERE type='config' AND key='solution'"
  local version
  handle:exec( sql, function ( udata, cols, values, names )
    version = json.decode( values[1] ).version
  end )
  return version
end

--- update the metarow table
-- with new version from resources folder,
-- it makes possible an update without overwrite user data
-- @param sqlite handle in ressource folder
-- @param sqlite handle in document folder
-- @return nothing
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

--- get a meta definition
-- JSON string with fun, val and calc keys
-- @param type of definition record (config, model, view, controller, template)
-- @param key point to the desired record
-- @return nothing
function MetaMan:getDefinition( type, key )
  local definition
  local sql =
    ([[SELECT value FROM _MetaRow WHERE type='%s' AND key='%s']]):format( type, key )
  self.handle:exec( sql, function ( udata, cols, values, names )
    definition =  values[1]
  end)
  return definition
end

--- find all screens
-- looks in /screens for all lua files
-- @treturn table with available screens
function MetaMan:allScreens( )
  local screens = { }
  local path = system.pathForFile( nil, system.ResourceDirectory ) .. "/screens"
  for screen in lfs.dir( path ) do
    if screen:sub(-4) == ".lua" then
      screens[#screens+1] = "screens." .. screen:sub( 1, -5 )
    end
  end
  return screens
end

--- get the next free screen
-- if no available it should remove the oldest ones
-- @treturn string name of the screen file
function MetaMan:getFreeScreen( )
  --TODO if no free screens call purgeScreens
  return table.remove( self.freeScreens, 1 )
end

--- get the screen name
-- for the desired view, views lives in screens via scene:create
-- @tparam string name of the view
-- @treturn string name of the screen
function MetaMan:getScreenName( viewName )
  local screenName
  if self.activeViews[viewName] then
    screenName = self.activeViews[viewName].screenName
  else
    screenName = self:getFreeScreen( )
  end
  return screenName
end

--- display a view
-- that lives in a screen
-- @tparam string name of the view
-- @return nothing
function MetaMan:gotoScreen( viewName )
  local composer = require"composer"
  local options = {
      effect = "fade",
      time = 500,
      params = {
        type = 'view',
        key = viewName
      }
  }
  composer.gotoScene( self:getScreenName( viewName ), options )
end

--- routes from a controller action to the connected view
-- loads and executes the controller definition
-- @tparam string name of the action
-- @return nothing
function MetaMan:call( action )
  self.controller:setData( self:getDefinition( 'controller', action ) )
  self:gotoScreen( self.controller:exec( ) )
end

--- loads all models from meta table
-- loads and executes the controller definition
-- @tparam string name of the action
-- @return nothing
function MetaMan:loadAllModels(  )
  local isOK
  for row in self.handle:nrows( "SELECT * FROM _MetaRow WHERE type = 'model';" ) do
    self.model:setData( row.value )
    isOK = self.model:exec( )
    if not isOK then break end
  end
  return isOK
end

return MetaMan
