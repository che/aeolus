
local Temp = {}


Temp.NAME = 'temp'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        temperature FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        temperature,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.8f');
]]


function Temp:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Temp:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.data_valid,
                                                data_table.timestamp,
                                                data_table.temperature,
                                                os.time()))
end

function Temp:delete(driver_obj, table_name, data_table)
    return nil
end


return Temp
