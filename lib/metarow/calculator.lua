--- RPN Calculator Module.
-- Based on the Stack class it provides a calculator with
-- Reverse Polish Notation: 1 2 add() = 1 + 2
-- @module calculator
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local Stack = require"lib.metarow.Stack"

local calc = Stack( )

--- Addition
-- pops two values from
-- @return the result
function calc:add( )
  local b, a = self:pop( 2 )
  self:push( a + b )
  return
end

--- Subtraction
-- pops two values from
-- @return the result
function calc:sub( )
  local b, a = self:pop( 2 )
  self:push( a - b )
  return
end

--- Multiplication
-- pops two values from
-- @return the result
function calc:mul( )
  local b, a = self:pop( 2 )
  self:push( a * b )
  return
end

--- Division
-- pops two values from
-- @return the result
function calc:div( )
  local b, a = self:pop( 2 )
  self:push( a / b )
  return
end

return calc
