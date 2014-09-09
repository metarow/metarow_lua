require"specs.spec_helper"
local sqlite3 = require "lsqlite3"
local json = require "json"

local MetaMan = require"lib.metarow.MetaMan"

describe( "basic functions", function( )
  it( "looks for a solution database", function( )
    local solutionName = "inventory"
    local root = MetaMan( solutionName )
    assert.is_not_nil( root )
    assert.is_not_nil( root.handle )
  end)
  it( "reads the solution version", function( )
    local solutionName = "inventory"
    local documentPath = system.pathForFile(
      solutionName .. ".sqlite", system.DocumentsDirectory
    )
    local handle = sqlite3.open( documentPath )
    local sql = "SELECT value FROM _MetaRow WHERE type='config' AND key='solution'"
    local version
    handle:exec( sql, function ( udata, cols, values, names )
      version = json.decode( values[1] ).version
    end)
    local root = MetaMan( solutionName )
    assert.are.equals( version, root.version)
  end)
end)
