
local GPS = {}


GPS.NAME = 'gps'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        has_fix INTEGER(2) NOT NULL,
        number_of_satellites INTEGER(2) NOT NULL,
        gps_timestamp_hour INTEGER(2) NOT NULL,
        gps_timestamp_min INTEGER(2) NOT NULL,
        gps_timestamp_sec INTEGER(4) NOT NULL,
        gps_timestamp_msec_mod INTEGER(3) NOT NULL,
        gps_timestamp_msec_div INTEGER(3) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        latitude FLOAT(4) NOT NULL,
        longitude FLOAT(4) NOT NULL,
        altitude FLOAT(4) NOT NULL,
        ground_speed FLOAT(4) NOT NULL,
        gps_bearing FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        has_fix,
        number_of_satellites,
        gps_timestamp_hour,
        gps_timestamp_min,
        gps_timestamp_sec,
        gps_timestamp_msec_mod,
        gps_timestamp_msec_div,
        timestamp,
        latitude,
        longitude,
        altitude,
        ground_speed,
        gps_bearing,
        created_at)
        VALUES ('%d', '%d', '%d', '%d', '%d', '%d', '%d', '%d', '%.8f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function GPS:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function GPS:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.has_fix,
                                                    data_table.number_of_satellites,
                                                    data_table.gps_timestamp_hour,
                                                    data_table.gps_timestamp_min,
                                                    data_table.gps_timestamp_sec,
                                                    data_table.gps_timestamp_msec_mod,
                                                    data_table.gps_timestamp_msec_div,
                                                    data_table.timestamp,
                                                    data_table.latitude,
                                                    data_table.longitude,
                                                    data_table.altitude,
                                                    data_table.ground_speed,
                                                    data_table.gps_bearing,
                                                    os.time()))
end

function GPS:delete(table_name, data_table)
    return nil
end


return GPS
