
local GPS = {}


GPS.NAME = 'gps'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        has_fix INTEGER(2) NOT NULL,
        number_of_satellites INTEGER(2) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        latitude FLOAT(4) NOT NULL,
        longitude FLOAT(4) NOT NULL,
        altitude FLOAT(4) NOT NULL,
        ground_speed FLOAT(4) NOT NULL,
        bearing FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        has_fix,
        number_of_satellites,
        timestamp,
        latitude,
        longitude,
        altitude,
        ground_speed,
        bearing,
        created_at)
        VALUES ('%d', '%d', '%d', '%.8f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function GPS:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function GPS:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.data_valid,
                                                data_table.has_fix,
                                                data_table.number_of_satellites,
                                                data_table.timestamp,
                                                data_table.latitude,
                                                data_table.longitude,
                                                data_table.altitude,
                                                data_table.ground_speed,
                                                data_table.bearing,
                                                os.time()))
end

function GPS:delete(driver_obj, table_name, data_table)
    return nil
end


return GPS
