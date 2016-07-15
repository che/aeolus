
local Wind = {}


Wind.NAME = 'wind'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        wind_magnitude FLOAT(4) NOT NULL,
        wind_direction FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        wind_magnitude,
        wind_direction,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f', '%.8f');
]]


function Wind:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Wind:insert(driver_obj, table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.timestamp,
                                                    data_table.wind_magnitude,
                                                    data_table.wind_direction,
                                                    os.time()))
end

function Wind:delete(table_name, data_table)
    return nil
end


return Wind
