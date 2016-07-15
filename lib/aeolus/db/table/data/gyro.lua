
local Gyro = {}


Gyro.NAME = 'gyro'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        gyro_x FLOAT(4) NOT NULL,
        gyro_y FLOAT(4) NOT NULL,
        gyro_z FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        gyro_x,
        gyro_y,
        gyro_z,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f', '%.16f', '%.8f');
]]

function Gyro:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Gyro:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.timestamp,
                                                    data_table.gyro_x,
                                                    data_table.gyro_y,
                                                    data_table.gyro_z,
                                                    os.time()))
end

function Gyro:delete(table_name, data_table)
    return nil
end


return Gyro
