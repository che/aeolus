
local Log = {}


Log.NAME = 'log'


local _SQL_TABLE_STRUCTURE = [[
        message VARCHAR(256)
]]


function Log:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Log:insert(driver_obj, table_name, data_table)
    return nil
end

function Log:delete(driver_obj, table_name, data_table)
    return nil
end


return Log
