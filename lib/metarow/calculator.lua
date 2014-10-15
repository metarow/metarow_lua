local Stack = require"lib.metarow.Stack"

local calc = Stack( )

function calc:add( )
  local b, a = self:pop( 2 )
  self:push( a + b )
  return
end

function calc:sub( )
  local b, a = self:pop( 2 )
  self:push( a - b )
  return
end

function calc:mul( )
  local b, a = self:pop( 2 )
  self:push( a * b )
  return
end

function calc:div( )
  local b, a = self:pop( 2 )
  self:push( a / b )
  return
end

return calc
