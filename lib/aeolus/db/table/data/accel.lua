
local Accel = {}


Accel.NAME = 'accel'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        accelerometer_x FLOAT(4) NOT NULL,
        accelerometer_y FLOAT(4) NOT NULL,
        accelerometer_z FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL,
        UNIQUE (timestamp, accelerometer_x, accelerometer_y, accelerometer_z)
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        accelerometer_x,
        accelerometer_y,
        accelerometer_z,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function Accel:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Accel:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.data_valid,
                                                data_table.timestamp,
                                                data_table.accelerometer_x,
                                                data_table.accelerometer_y,
                                                data_table.accelerometer_z,
                                                os.time()))
end

function Accel:delete(driver_obj, table_name, data_table)
    return nil
end


return Accel
