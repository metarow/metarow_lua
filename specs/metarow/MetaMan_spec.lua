require"specs.spec_helper"
local sqlite3 = require "lsqlite3"
local json = require "json"
local lfs = require "lfs"

local base = require"lib.loop.base"
local MetaMan = require"lib.metarow.MetaMan"
local MetaJSON = require"lib.metarow.MetaJSON"

local solutionName = metarow.defaultSolution
local resourcePath = system.pathForFile(
  "data/" .. solutionName .. ".sqlite", system.ResourceDirectory
)
local documentPath = system.pathForFile(
  solutionName .. ".sqlite", system.DocumentsDirectory
)
local createMetaTableString = [[
  CREATE TABLE "_MetaRow" (
    "type" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT,
    CONSTRAINT "type_key" PRIMARY KEY ("type", "key")
  );
]]
local f
f = io.open( 'specs/metarow/view_string_01.json', "r" )
local viewString = f:read( "*a" )
f = io.open( 'specs/metarow/controller_string_01.json', "r" )
local controllerString = f:read( "*a" )
f = io.open( 'specs/metarow/model_string_01.json', "r" )
local modelString_01 = f:read( "*a" )
f = io.open( 'specs/metarow/model_string_02.json', "r" )
local modelString_02 = f:read( "*a" )

local table = require "table"
function table.contains( table, element )
  for _, value in pairs( table ) do
    if value == element then
      return true
    end
  end
  return false
end

describe( "basic functions", function( )
  it( "looks for a solution database", function( )
    local root = MetaMan{ solutionName=solutionName }
    assert.is_not_nil( root )
    assert.is_not_nil( root.handle )
  end)

  it( "reads the solution version", function( )
    local handle = sqlite3.open( documentPath )
    local version = MetaMan.getVersion( handle )
    local root = MetaMan{ solutionName=solutionName }
    assert.are.equals( version, root.version)
  end)

  it( "updates the meta table for higher system version", function( )
    local solutionName = metarow.defaultSolution
    local handle_res = sqlite3.open( resourcePath )
    local version_res = MetaMan.getVersion( handle_res )
    local handle_doc = sqlite3.open( documentPath )
    local stmt = handle_doc:prepare[[
      UPDATE _MetaRow SET value=:value
      WHERE type='config' AND key='solution';
    ]]
    stmt:bind_names{ value=[[{"version":"0.0"}]] }
    stmt:step()
    local root = MetaMan{ solutionName=solutionName }
    assert.are.equals( version_res, root.version)
  end)

  it( "loads a json string from database", function( )
    local root = MetaMan( )
    assert.is_not_nil( root )
    root.handle:exec( createMetaTableString )
    local  sql = ([[
      INSERT INTO _MetaRow (type, key, value)
      VALUES ( 'view', 'index', '%s');
    ]]):format( viewString )
    root.handle:exec( sql )
    local d = json.decode( root:getDefinition( 'view', 'index' ) )
    assert.are.equals( 'createRect', d[1].fun.name )
  end)
end)


describe( "works with a view object", function( )
  local composer = require"composer"

  it( "init a view creator", function( )
    local root = MetaMan( )
    assert.is_not_nil( root.view )
    assert.is_true( base.instanceof( root.view, MetaJSON ))
  end)

  it( "has a active views table", function( )
    local root = MetaMan( )
    assert.is_true( type( root.activeViews ) == "table" )
  end)

  it( "provides a function for get all screens", function( )
    local root = MetaMan( )
    assert.is_true( type( root.allScreens ) == "function" )
    local screens = { }
    local path = system.pathForFile( nil, system.ResourceDirectory ) .. "/screens"
    for screen in lfs.dir( path ) do
      if screen:sub(-4) == ".lua" then
        screens[#screens+1] = "screens." .. screen:sub( 1, -5 )
      end
    end
    assert.are.equals( #screens, #root:allScreens( ) )
  end)

  it( "has a list of free screens", function( )
    local root = MetaMan( )
    assert.is_true( type( root.freeScreens ) == "table" )
    assert.are.equals( #root:allScreens( ), #root.freeScreens )
    assert.is_true( table.contains( root.freeScreens, "screens.02" ) )
  end)

  it( "finds the first free screen and deletes it from list", function( )
    local root = MetaMan( )
    local firstScreen = root.freeScreens[1]
    local nextScreen = root.freeScreens[2]
    assert.are.equals( firstScreen, root:getFreeScreen( ) )
    assert.are.equals( nextScreen, root:getFreeScreen( ) )
  end)

  it( "gets the screen name for a view", function( )
    local root = MetaMan( )
    assert.are.equals( 'screens.01', root:getScreenName( 'index' ) )
  end)

  it( "encapsulates composer.gotoScene", function( )
    local root = MetaMan( )
    assert.is_true( type( root.gotoScreen ) == "function" )
    local s = spy.on( composer, "gotoScene" )
    root:gotoScreen( 'index' )
    assert.spy( composer.gotoScene ).was.called( )
  end)
end)

describe( "works with a controller object", function( )
  it( "init a controller creator", function( )
    local root = MetaMan( )
    assert.is_not_nil( root.controller )
    assert.is_true( base.instanceof( root.controller, MetaJSON ))
  end)

  it( "calls an action", function( )
    local root = MetaMan( )
    assert.is_true( type( root.call ) == "function" )
    root.handle:exec( createMetaTableString )
    local sql = ([[
      INSERT INTO _MetaRow (type, key, value)
      VALUES ( 'controller', 'index', '%s');
    ]]):format( controllerString )
    root.handle:exec( sql )

    local f1 = spy.on( root.controller, "setData" )
    local f2 = spy.on( root, "getDefinition" )
    local f3 = spy.on( root, "gotoScreen" )
    local f4 = spy.on( root.controller, "exec" )
    local action = "index"
    root:call( action )
    assert.spy( f1 ).was.called( )
    assert.spy( f2 ).was.called_with( root, "controller", action )
    assert.spy( f3 ).was.called( )
    assert.spy( f4 ).was.called_with( root.controller )

  end)
end)

describe( "works with a template object", function( )
  it( "init a template creator", function( )
    local root = MetaMan( )
    assert.is_not_nil( root.template )
    assert.is_true( base.instanceof( root.template, MetaJSON ))
  end)
end)

_root = MetaMan( )

describe( "works with models", function ( )
  local tableName = { 'objects', 'categories' }
  _root.handle:exec( createMetaTableString )
  local  sql = [[
    INSERT INTO _MetaRow (type, key, value)
    VALUES ( 'model', '%s', '%s');
  ]]
  _root.handle:exec( sql:format( tableName[1], modelString_01 ) )
  _root.handle:exec( sql:format( tableName[2], modelString_02 ) )

  it( "inits a model creator", function( )
    assert.is_not_nil( _root.model )
    assert.is_true( base.instanceof( _root.model, MetaJSON ))
  end)

  it( "loads all models", function( )
    assert.is_true( type( _root.loadAllModels ) == "function" )
    local isOK = _root:loadAllModels()
    assert.is_not_nil( isOK )
    assert.is_not_nil( metarow.models )
    assert.is_not_nil( metarow.models[tableName[1]] )
    assert.is_not_nil( metarow.models[tableName[2]].objects )
    assert.is_not_nil( metarow.models[tableName[1]].scopes )
  end)
end)
