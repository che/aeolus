
local Wind = {}


Wind.NAME = 'wind'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        wind_magnitude FLOAT(16) NOT NULL,
        wind_direction FLOAT(16) NOT NULL
]]


function Wind:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Wind:insert(driver_obj, table_name, data_table)
    return nil
end

function Wind:delete(driver_obj, table_name, data_table)
    return nil
end


return Wind
