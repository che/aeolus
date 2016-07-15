
local Magnet = {}


Magnet.NAME = 'magnet'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        magnetometer_x FLOAT(4) NOT NULL,
        magnetometer_y FLOAT(4) NOT NULL,
        magnetometer_z FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        magnetometer_x,
        magnetometer_y,
        magnetometer_z,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function Magnet:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Magnet:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.timestamp,
                                                    data_table.magnetometer_x,
                                                    data_table.magnetometer_y,
                                                    data_table.magnetometer_z,
                                                    os.time()))
end

function Magnet:delete(table_name, data_table)
    return nil
end


return Magnet
