require"specs.spec_helper"
local simple = require"lib.loop.simple"

describe( "basic functions", function( )
  it( "creates instances", function( )
    local object = TableViewWidget( )
    assert.is_not_nil( object )
    assert.is_true( simple.instanceof( object, TableViewWidget ) )
    assert.is_true( simple.subclassof( TableViewWidget, EventListener ) )
  end)

  it( "can insert rows", function( )
    assert.is_true( type( TableViewWidget.insertRow ) == "function" )

    local row = { }
    local function onRowRender( event )
      row = event.row
    end

    local object = TableViewWidget{ onRowRender = onRowRender }
    local options = { rowHeight = 50, params = { } }
    object:insertRow( options )
    assert.are.equals( 1, row.index )
    assert.are.equals( 50, row.height )
  end)

end)
