require"specs.spec_helper"

local model = require"lib.metarow.model"

describe( "basic functions", function( )
  it( "has functions", function( )
    assert.is_true( type( model.checkTable ) == "function" )
    assert.is_true( type( model.mapFields ) == "function" )
  end)
end)

local f = io.open( 'specs/metarow/model_string_01.json', "r" )
local jsonString = f:read( "*a" )

local MetaMan = require"lib.metarow.MetaMan"
_root = MetaMan( )
model:setData( jsonString )

describe( "checks a table structure", function( )
  model:exec( )

  it( "creates a missing table", function( )
    local fields = {}
    for row in _root.handle:nrows( "PRAGMA table_info('objects');" ) do
      fields[#fields+1] = row
    end
    assert.are.equals( 3,  #fields )
    assert.are.equals( 'id', fields[1].name )
    assert.are.equals( 1, fields[1].pk )
    assert.are.equals( 'TEXT', fields[2].type )
    assert.are.equals( 1, fields[3].notnull )
    assert.are.equals( 0, fields[3].pk )
  end)

  it( "inserts examples", function( )
    local rows = {}
    for row in _root.handle:nrows( "SELECT * FROM objects;" ) do
      rows[#rows+1] = row
    end
    assert.are.equals( 2,  #rows )
  end)
end)

describe( "sets the desired model in metarow namespace", function( )
  local categoriesTableString = [[
    CREATE TABLE categories (
      id INTEGER NOT NULL,
      name TEXT NOT NULL
    );
    INSERT INTO categories VALUES ( 1, 'furnitures');
    INSERT INTO categories VALUES ( 2, 'paintings');
  ]]
  _root.handle:exec( categoriesTableString )

  local tableName = 'objects'
  local isOK = model:exec( )

  it( "chains the status", function( )
    assert.is_not_nil( isOK )
  end)

  it( "stores all stuff in metarow.models", function(  )
    assert.is_not_nil( metarow.models[tableName] )
    assert.is_not_nil( metarow.models[tableName].objects )
    assert.is_not_nil( metarow.models[tableName].scopes )
  end)

  it( "performs the mapping", function( )
    local rows = {}
    for row in _root.handle:nrows( "SELECT * FROM objects;" ) do
      rows[#rows+1] = metarow.models[tableName].objects( row )
    end
    assert.are.equals( 1, rows[1].id )
    assert.is_true( type( rows[1].id ) == 'number')
    assert.are.equals( "chair", rows[1].name )
    assert.is_true( type( rows[1].name ) == 'string')
    assert.are.equals( "paintings", rows[2].category )
    assert.is_true( type( rows[2].category ) == 'string')
  end)
end)
