
local Gyro = {}


Gyro.NAME = 'gyro'


local SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        gyro_x FLOAT(16) NOT NULL,
        gyro_y FLOAT(16) NOT NULL,
        gyro_z FLOAT(16) NOT NULL,
]]


function Gyro:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Gyro:insert(driver_obj, table_name, data_table)
    return nil
end

function Gyro:delete(driver_obj, table_name, data_table)
    return nil
end


return Gyro
