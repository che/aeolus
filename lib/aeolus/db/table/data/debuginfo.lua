
local DebugInfo = {}


DebugInfo.NAME = 'debuginfo'


local SQL_TABLE_STRUCTURE = [[
        message VARCHAR(256),
]]


function DebugInfo:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function DebugInfo:insert(driver_obj, table_name, data_table)
    return nil
end

function DebugInfo:delete(driver_obj, table_name, data_table)
    return nil
end


return DebugInfo
