--- Lua Object-Oriented Programming.
-- Base Class Model
-- @module base
-- @author Renato Maia <maia@inf.puc-rio.br>
-- (basic implementation)
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>
-- (new way module creation, ldoc style comments)

local base = {}

--- Makes object an instance of class.
-- Sets the meta-table of object to table class.
-- @param class meta-table
-- @param object
-- @return a table
function base.rawnew( class, object )
	return setmetatable( object or {}, class )
end

--- Constructs an instance of class.
-- Call an optional __init function
-- @param class
-- @param ... values of the extra arguments
-- @return an instance of class
function base.new( class, ... )
	if class.__init
		then return class:__init( ... )
		else return base.rawnew( class, ... )
	end
end

--- Initialize table as a class.
-- Sets the value __index field of class to refer itself,
-- unless such field provides a value different from nil
-- @param class table to be transformed
-- @return a table that acts as class
function base.initclass( class )
	if class == nil then class = {} end
	if class.__index == nil then class.__index = class end
	return class
end

local MetaClass = { __call = base.new }

--- Create an object that represent a class.
-- This object can also be used as a constructor of instances.
-- Changes on the object returned by this function
-- implies changes reflected on all its instances.
-- @param class table define features for all objects
-- @return a class
function base.class( class )
	return setmetatable( base.initclass( class ), MetaClass )
end

--- Returns the class of object.
-- For the base model this function is the getmetatable function.
-- @function classof
-- @param object an instance of class
-- @return class
base.classof = getmetatable

--- Check if the class is defined with LOOP.
-- @param class to be check
-- @return boolean true if LOOP
function base.isclass( class )
	return base.classof( class ) == MetaClass
end

--- Check object is instance of class.
--@param object to be check
--@param class to be check
--@return boolean true if an instance
function base.instanceof( object, class )
	return base.classof( object ) == class
end

--- Has class a member defined by name.
-- Gets the real value of class[name], without invoking any metamethod.
-- @function memberof
-- @param class to be check
-- @param name of member
-- @return member or nil
base.memberof = rawget

--- Get an iterator through all the members defined by the class.
-- The iteration variables hold the field name and value respectively.
-- @function members
-- @param class
-- @return an iterator that may be used in a for statement
base.members = pairs

return base
