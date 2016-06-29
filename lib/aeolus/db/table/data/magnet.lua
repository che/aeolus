
local Magnet = {}


Magnet.NAME = 'magnet'


local SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        magnetometer_x FLOAT(16) NOT NULL,
        magnetometer_y FLOAT(16) NOT NULL,
        magnetometer_z FLOAT(16) NOT NULL,
]]


function Magnet:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Magnet:insert(driver_obj, table_name, data_table)
    return nil
end

function Magnet:delete(driver_obj, table_name, data_table)
    return nil
end


return Magnet
