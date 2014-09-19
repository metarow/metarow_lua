require"specs.spec_helper"
local sqlite3 = require "lsqlite3"
local json = require "json"

local base = require"lib.loop.base"
local MetaMan = require"lib.metarow.MetaMan"
local MetaJSON = require"lib.metarow.MetaJSON"


local solutionName = "inventory"
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
local f = io.open( 'specs/metarow/view_string.json', "r" )
local viewString = f:read( "*a" )

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
    local solutionName = "inventory"
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
    local root = MetaMan{ }
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

describe( "build mvc objects", function( )
  it( "init a view creator", function( )
    local root = MetaMan{ }
    assert.is_not_nil( root.view )
    assert.is_true( base.instanceof( root.view, MetaJSON ))

  end)
end)
