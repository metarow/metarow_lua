require"specs.spec_helper"

describe( "basic functions", function( )
  it( "get information about the system", function( )
    assert.are.equals( "MetaRow", system.getInfo( "appName" ) )
    assert.are.equals( "test", system.getInfo( "environment" ) )
  end)

  it( "defines directory constants", function( )
    assert.are.equals( lfs.currentdir(), system.ResourceDirectory[1] )
    assert.are.equals(
      lfs.currentdir() .. "/test/Documents", system.DocumentsDirectory[1]
    )
    assert.are.equals(
      lfs.currentdir() .. "/test/tmp", system.TemporaryDirectory[1]
    )
  end)

  it( "returns directory constant for no file", function( )
    assert.are.equals(
      system.ResourceDirectory[1],
      system.pathForFile( nil, system.ResourceDirectory )
    )
  end)

  it( "generates a path to file", function( )
    assert.are.equals(
      system.ResourceDirectory[1] .. "/data/inventory.sqlite",
      system.pathForFile( "data/inventory.sqlite", system.ResourceDirectory )
    )
    assert.are.equals(
      system.ResourceDirectory[1] .. "/data/inventory.sqlite",
      system.pathForFile( "data/inventory.sqlite" )
    )
    assert.is_nil( system.pathForFile( "data/order.sqlite" ) )
    assert.are.equals(
      system.DocumentsDirectory[1] .. "/inventory.sqlite",
      system.pathForFile( "inventory.sqlite", system.DocumentsDirectory )
    )
  end)
end)
