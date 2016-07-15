
local DebugInfo = {}


DebugInfo.NAME = 'debuginfo'


local _SQL_TABLE_STRUCTURE = [[
        message VARCHAR(256)
]]


function DebugInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function DebugInfo:insert(table_name, data_table)
    return nil
end

function DebugInfo:delete(table_name, data_table)
    return nil
end


return DebugInfo
