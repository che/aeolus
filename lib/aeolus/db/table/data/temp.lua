
local Temp = {}


Temp.NAME = 'temp'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        temperature FLOAT(16) NOT NULL
]]


function Temp:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Temp:insert(driver_obj, table_name, data_table)
    return nil
end

function Temp:delete(driver_obj, table_name, data_table)
    return nil
end


return Temp
