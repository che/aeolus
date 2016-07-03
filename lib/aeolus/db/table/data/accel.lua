
local Accel = {}


Accel.NAME = 'accel'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        accelerometer_x FLOAT(16) NOT NULL,
        accelerometer_y FLOAT(16) NOT NULL,
        accelerometer_z FLOAT(16) NOT NULL
]]


function Accel:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Accel:insert(driver_obj, table_name, data_table)
    return nil
end

function Accel:delete(driver_obj, table_name, data_table)
    return nil
end


return Accel
