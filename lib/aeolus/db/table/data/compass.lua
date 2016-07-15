
local Compass = {}


Compass.NAME = 'compass'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        calibration_status VARCHAR(2) NOT NULL,
        has_value INTEGER(1) NOT NULL,
        calibration_per VARCHAR(2) NOT NULL,
        calibration_per_remaining_time VARCHAR(2) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        compass_heading FLOAT(4) NOT NULL,
        soft_calibration_params_1 FLOAT(4) NOT NULL,
        soft_calibration_params_2 FLOAT(4) NOT NULL,
        soft_calibration_params_3 FLOAT(4) NOT NULL,
        hard_iron_calibration_1 FLOAT(4) NOT NULL,
        hard_iron_calibration_2 FLOAT(4) NOT NULL,
        hard_iron_calibration_3 FLOAT(4) NOT NULL,
        hard_iron_calibration_4 FLOAT(4) NOT NULL,
        hard_iron_calibration_5 FLOAT(4) NOT NULL,
        hard_iron_calibration_6 FLOAT(4) NOT NULL,
        hard_iron_calibration_7 FLOAT(4) NOT NULL,
        hard_iron_calibration_8 FLOAT(4) NOT NULL,
        hard_iron_calibration_9 FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        calibration_status,
        has_value,
        calibration_per,
        calibration_per_remaining_time,
        timestamp,
        compass_heading,
        soft_calibration_params_1,
        soft_calibration_params_2,
        soft_calibration_params_3,
        hard_iron_calibration_1,
        hard_iron_calibration_2,
        hard_iron_calibration_3,
        hard_iron_calibration_4,
        hard_iron_calibration_5,
        hard_iron_calibration_6,
        hard_iron_calibration_7,
        hard_iron_calibration_8,
        hard_iron_calibration_9,
        created_at)
        VALUES ('%d','%s','%d','%s', '%s', '%.8f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function Compass:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Compass:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.calibration_status,
                                                    data_table.has_value,
                                                    data_table.calibration_per,
                                                    data_table.calibration_per_remaining_time,
                                                    data_table.timestamp,
                                                    data_table.compass_heading,
                                                    data_table.soft_calibration_params_1,
                                                    data_table.soft_calibration_params_2,
                                                    data_table.soft_calibration_params_3,
                                                    data_table.hard_iron_calibration_1,
                                                    data_table.hard_iron_calibration_2,
                                                    data_table.hard_iron_calibration_3,
                                                    data_table.hard_iron_calibration_4,
                                                    data_table.hard_iron_calibration_5,
                                                    data_table.hard_iron_calibration_6,
                                                    data_table.hard_iron_calibration_7,
                                                    data_table.hard_iron_calibration_8,
                                                    data_table.hard_iron_calibration_9,
                                                    os.time()))
end

function Compass:delete(table_name, data_table)
    return nil
end


return Compass
