require"specs.spec_helper"

describe( "basic functions", function( )
  it( "get information about the system", function( )
    assert.are.equals( "MetaRow", system.getInfo( "appName" ) )
    assert.are.equals( "test", system.getInfo( "environment" ) )
  end)

  it( "defines directory constants", function( )
    assert.are.equals( "/tmp/MetaRow/Documents", system.DocumentsDirectory )
    assert.are.equals( "/tmp/MetaRow/tmp", system.TemporaryDirectory )
    assert.are.equals( "/Volumes/HDD/Code/metarow_lua", system.ResourceDirectory )
  end)

  it( "generates an absolute path", function( )
    local absolutePath = system.ResourceDirectory .. "/data/inventory.sqlite"
    assert.are.equals(
      absolutePath,
      system.pathForFile( "data/inventory.sqlite", system.ResourceDirectory )
    )
    assert.are.equals(
      absolutePath, system.pathForFile( "data/inventory.sqlite" )
    )
    assert.is_nil( system.pathForFile( "data/order.sqlite" ) )
    absolutePath = system.DocumentsDirectory .. "/inventory.sqlite"
    assert.are.equals(
      absolutePath,
      system.pathForFile( "inventory.sqlite", system.DocumentsDirectory )
    )
  end)
end)
