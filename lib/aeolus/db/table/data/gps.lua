
local GPS = {}


GPS.NAME = 'gps'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        has_fix INTEGER(2) NOT NULL,
        number_of_sattellites INTEGER(4) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        lalitude FLOAT(16) NOT NULL,
        longitude FLOAT(16) NOT NULL,
        altitude FLOAT(16) NOT NULL,
        ground_speed FLOAT(16) NOT NULL
]]


function GPS:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function GPS:insert(driver_obj, table_name, data_table)
    return nil
end

function GPS:delete(driver_obj, table_name, data_table)
    return nil
end


return GPS
