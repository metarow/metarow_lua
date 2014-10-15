local ObjectCache = require"lib.loop.collection.ObjectCache"
local base = require 'lib.loop.base'

describe( "basic functions", function( )
  it( "provides a class constructor", function( )
    assert.is_true( base.isclass( ObjectCache ))
  end)

  it( "return nothing for missing key", function( )
    local c = ObjectCache( )
    assert.is_nil( c[''] )
  end)

  it( "uses a provided retrieve function", function( )
    local setCache = false
    local c = ObjectCache{
      retrieve = function( self, key )
      setCache = true
        local values = { a = 'A' }
        return values[ key ]
      end
    }
    assert.are.equals( 'A', c['a'])
    assert.is_true( setCache )
    setCache = false
    assert.are.equals( 'A', c['a'])
    assert.is_false( setCache )
  end)

  it( "uses a provided default function", function( )
    local c = ObjectCache{
      default = 'lua'
    }
    assert.are.equals( 'lua', c['a'])
  end)
end)
