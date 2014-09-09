require"specs.spec_helper"
local sqlite3 = require "lsqlite3"
local json = require "json"

local MetaMan = require"lib.metarow.MetaMan"

local solutionName = "inventory"
local resourcePath = system.pathForFile(
  "data/" .. solutionName .. ".sqlite", system.ResourceDirectory
)
local documentPath = system.pathForFile(
  solutionName .. ".sqlite", system.DocumentsDirectory
)

describe( "basic functions", function( )
  it( "looks for a solution database", function( )
    local root = MetaMan( solutionName )
    assert.is_not_nil( root )
    assert.is_not_nil( root.handle )
  end)
  it( "reads the solution version", function( )
    local handle = sqlite3.open( documentPath )
    local version = MetaMan.getVersion( handle )
    local root = MetaMan( solutionName )
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
    local root = MetaMan( solutionName )
    assert.are.equals( version_res, root.version)
  end)
end)
