
local DebugInfo = {}


DebugInfo.NAME = 'debuginfo'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        created_at)
        VALUES ('%d', '%.8f', '%.8f');
]]


function DebugInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function DebugInfo:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.timestamp,
                                                    os.time()))
end

function DebugInfo:delete(table_name, data_table)
    return nil
end


return DebugInfo
