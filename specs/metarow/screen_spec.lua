require"specs.spec_helper"

local MetaMan = require"lib.metarow.MetaMan"
local screen = require"lib.metarow.screen"

local f = io.open( 'specs/metarow/view_string_01.json', "r" )
local viewString = f:read( "*a" )
f = io.open( 'specs/metarow/template_string.json', "r" )
local templateString = f:read( "*a" )

local createMetaTableString = ([[
  CREATE TABLE "_MetaRow" (
    "type" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT,
    CONSTRAINT "type_key" PRIMARY KEY ("type", "key")
  );
  INSERT INTO _MetaRow (type, key, value)
    VALUES ( 'view', 'index', '%s');
  INSERT INTO _MetaRow (type, key, value)
    VALUES ( 'template', 'inventory', '%s');
]]):format( viewString, templateString )

metarow.root = MetaMan( )
metarow.root.handle:exec( createMetaTableString )

local key = 'index'
local event = {
  params = {
    type = 'view',
    key = key
  }
}

local screenName = "screens.01"

describe( "basic functions", function( )
  it( "loads scene data", function( )
    screen.loadScene( screenName, event )
    assert.are.equals( screenName, metarow.root.activeViews[key].screenName )
    assert.are.equals( 'inventory', metarow.root.activeTemplate.name )
  end)
end)
