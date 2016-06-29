
local Compass = {}


Compass.NAME = 'compass'


local SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        calibration_status VARCHAR(2) NOT NULL,
        has_value INTEGER(1) NOT NULL,
        calibration_per VARCHAR(2) NOT NULL,
        calibration_per_remaining_time VARCHAR(2) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        compass_heading FLOAT(16) NOT NULL,
        soft_calibration_params_1 FLOAT(16) NOT NULL,
        soft_calibration_params_2 FLOAT(16) NOT NULL,
        soft_calibration_params_3 FLOAT(16) NOT NULL,
        hard_iron_calibration_1 FLOAT(16) NOT NULL,
        hard_iron_calibration_2 FLOAT(16) NOT NULL,
        hard_iron_calibration_3 FLOAT(16) NOT NULL,
        hard_iron_calibration_4 FLOAT(16) NOT NULL,
        hard_iron_calibration_5 FLOAT(16) NOT NULL,
        hard_iron_calibration_6 FLOAT(16) NOT NULL,
        hard_iron_calibration_7 FLOAT(16) NOT NULL,
        hard_iron_calibration_8 FLOAT(16) NOT NULL,
        hard_iron_calibration_9 FLOAT(16) NOT NULL,
]]


function Compass:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Compass:insert(driver_obj, table_name, data_table)
    return nil
end

function Compass:delete(driver_obj, table_name, data_table)
    return nil
end


return Compass
