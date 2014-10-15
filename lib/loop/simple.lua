--- Lua Object-Oriented Programming.
-- Simple Inheritance Class Model
-- @module simple
-- @author Renato Maia <maia@inf.puc-rio.br>
-- (basic implementation)
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>
-- (new way module creation, ldoc style comments)

local table = require "lib.loop.table"

local simple = {}

local ObjectCache = require "lib.loop.collection.ObjectCache"
local base = require "lib.loop.base"

table.copy( base, simple )

--- Constructs an instance of class.
-- Call an optional __init function
-- @param class
-- @param args values of the extra arguments
-- @return an instance of class
function simple.new( class, args )
  local inits = { }
  local super = class
  while super do
    if super.__init then
      inits[#inits+1] = super.__init
    end
    super = simple.superclass( super )
  end
  local attribs
  if #inits then
    attribs = { }
    for i=#inits, 1, -1 do
      attribs = table.merge( attribs, inits[i]( class, args ) )
    end
  else
    attribs = args or { }
  end
  return base.rawnew( class, attribs )
end

local DerivedClass = ObjectCache {
  retrieve = function( self, super )
    return base.class { __index = super, __call = simple.new }
  end,
}

--- Create an object that represent a class.
-- This object can also be used as a constructor of instances.
-- Changes on the object returned by this function
-- implies changes reflected on all its instances.
-- @param args table define properties for all objects
-- @param args.__super inherits from the class super.
-- @return a class
function simple.class( args )
  args = args or { }
  if args.__super then
    local super = args.__super
    args.super = nil
    return DerivedClass[super]( simple.initclass( args ) )
  else
    return base.class( args )
  end
end

--- Check if the class is defined with LOOP.
-- @param class to be check
-- @return boolean true if LOOP
function simple.isclass( class )
  local metaclass = simple.classof( class )
  if metaclass then
    return
      metaclass == rawget( DerivedClass, metaclass.__index ) or
      base.isclass( class )
  end
end

--- Returns the super-class
-- If class is not a class of the model or does not define a super class,
-- then it returns nil.
--@param class to be check
--@return super-class
function simple.superclass( class )
  local metaclass = simple.classof( class )
  if metaclass then return metaclass.__index end
end

--- Check if a class is a sub-class of super
--@param class to be check
--@param super to be check
--@return boolean true if a sub-class
function simple.subclassof( class, super )
  while class do
    if class == super then return true end
    class = simple.superclass( class )
  end
  return false
end

--- Check object is instance of class.
--@param object to be check
--@param class to be check
--@return boolean true if an instance
function simple.instanceof( object, class )
  return simple.subclassof( simple.classof( object ), class )
end

return simple
