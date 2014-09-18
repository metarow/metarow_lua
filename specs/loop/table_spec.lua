local table = require"lib.loop.table"

describe( "basic functions", function( )
  it( "copies a table item wise", function( )
    local t1 = { first=1, second=2 }
    t1[1] = 'lua'
    local t2 = { }
    table.copy( t1, t2 )
    assert.are.equals( t1[1], t2[1] )
    assert.are.equals( 1, #t2 )
    assert.are.equals( t1.first, t2.first )
    local t3 = table.copy( t1 )
    assert.are.equals( t1.second, t3.second )
  end)

  it( "clears all items of a table", function( )
    local t1 = { first=1, second=2 }
    t1[1] = 'lua'
    assert.are.equals( 1, #t1)
    table.clear( t1 )
    assert.is_nil( t1.first )
    assert.is_nil( t1.second )
    assert.are.equals( 0, #t1)
  end)
end)
