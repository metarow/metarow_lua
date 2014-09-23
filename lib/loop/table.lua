--- Lua Object-Oriented Programming.
-- General utilities functions for table manipulation
-- @module table
-- @author Renato Maia <maia@inf.puc-rio.br>
-- (basic implementation)
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>
-- (new way module creation, merge to tables)

local table = require "table"

--- Copies all elements stored in a table into another.
-- Each pair of key and value stored in table 'source' will be set into table
-- 'destiny'.
-- If no 'destiny' table is defined, a new empty table is used.
-- @param source Table containing elements to be copied.
-- @param destiny [optional] Table which elements must be copied into.
-- @return Table containing copied elements.
-- @usage copied = loop.table.copy(results)
-- @usage loop.table.copy(results, newcopy)
function table.copy( source, destiny )
  if source then
    if not destiny then destiny = {} end
    for field, value in pairs( source ) do
      rawset( destiny, field, value )
    end
  end
  return destiny
end

--- Clears all contens of a table.
-- All pairs of key and value stored in table 'source' will be removed by
-- setting nil to each key used to store values in table 'source'.
-- @param tab Table which must be cleared.
-- @usage return loop.table.clear(results)
function table.clear( tab )
  local elem = next( tab )
  while elem ~= nil do
    tab[elem] = nil
    elem = next( tab )
  end
  return tab
end

--- Merges two tables
-- All keys from tab1 overlayed with keys from tab2
-- @param tab1 table with orignal elements
-- @param tab2 table with elements to merge
-- @return table with all merged elements
function table.merge( tab1, tab2 )
  for k, v in pairs( tab2 ) do tab1[k] = v end
  return tab1
end

return table
