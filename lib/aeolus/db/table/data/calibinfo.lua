
local CalibInfo = {}


CalibInfo.NAME = 'calibinfo'


local _SQL_TABLE_STRUCTURE = [[
        message VARCHAR(256)
]]


function CalibInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function CalibInfo:insert(table_name, data_table)
    return nil
end

function CalibInfo:delete(table_name, data_table)
    return nil
end


return CalibInfo
