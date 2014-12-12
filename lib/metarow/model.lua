--- Model Module.
-- defines the available model functions
-- inherit from MetaJSON
-- @module model
-- @author Fritz-Rainer Doebbelin <frd@doebbelin.net>

local MetaJSON = require"lib.metarow.MetaJSON"
local model = MetaJSON( )

local Stack = require"lib.metarow.Stack"
model.stack = Stack( )

--- check a database table
-- if missing then create a new table
-- if structure different form meta table then alter table
-- called from solution init
-- @tparam table params from JSON string
-- @treturn boolean table is ok
function model.checkTable( params )
  local fields = {}
  for row in metarow.root.handle:nrows(
    ( "PRAGMA table_info('%s');" ):format( params.table )
  ) do
    fields[#fields+1] = row
  end
  if #fields == 0 then
    local columns = { }
    for _, field in ipairs( params.fields ) do
      columns[#columns+1] = table.concat( field, " " )
    end
    local createTableString =
      ("CREATE TABLE %s (%s);"):format( params.table, table.concat( columns, "," ))
    metarow.root.handle:exec( createTableString )
    for _, example in ipairs( params.examples ) do
      local insertTableString = ("INSERT INTO %s VALUES (%s);"):format( params.table, example )
      metarow.root.handle:exec( insertTableString )
    end
  else
    --TODO check against _MetaRow
  end
  return true
end

--- map table fields to lua objects
-- constructs all required translations for user defined objects
-- @tparam table params from JSON string
-- @treturn boolean model is OK
function model.mapFields( params )
  local isOK = model.stack:pop( )
  if isOK then
    metarow.models[params.table] = { }
    metarow.models[params.table].objects = function( row )
      local data = { }
      for object, mapping in pairs( params.objects ) do
        --TODO format numbers conforming locals
        if mapping.type == "number" or mapping.type == "string" then
          data[object] = row[mapping.field]
        elseif mapping.type == "lookup" then
          local value
          local sql =
            ("SELECT %s FROM %s WHERE id=%i;"):format(
              mapping.target.field, mapping.target.name, row[mapping.field]
            )
          metarow.root.handle:exec( sql, function ( udata, cols, values, names )
            value = values[1]
          end)
          data[object] = value
        end
      end

      return data
    end
    metarow.models[params.table].scopes = params.scopes
    isOK = true
  end
  return isOK
end

--- execute the model definition
-- is called by MetaMan:model
-- @treturn table model definition
function model:exec(  )
  for i, element in ipairs( self.data ) do
    local result = self:getMeta( element )
    if result then model.stack:push( result ) end
  end
  return model.stack:pop( )
end

return model
