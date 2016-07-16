
local CalibInfo = {}


CalibInfo.NAME = 'calibinfo'


local _SQL_TABLE_STRUCTURE = [[
        calibration_enable_1 INTEGER(1),
        calibration_enable_2 INTEGER(1),
        calibration_working INTEGER(1),
        has_value INTEGER(1),
        temperature_calibrated_n INTEGER(1),
        mac_address VARCHAR(17),
        info_n_runs_per INTEGER(2),
        info_n_runs INTEGER(2),
        temperature FLOAT(4) NOT NULL,
        calibration_sum FLOAT(4) NOT NULL,
        temperature_oat FLOAT(4) NOT NULL,
        temperature_calibrated_min FLOAT(4) NOT NULL,
        temperature_calibrated_max FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        calibration_enable_1,
        calibration_enable_2,
        calibration_working,
        has_value,
        temperature_calibrated_n,
        mac_address,
        info_n_runs_per,
        info_n_runs,
        temperature,
        calibration_sum,
        temperature_oat,
        temperature_calibrated_min,
        temperature_calibrated_max,
        created_at)
        VALUES ('%d', '%d', '%d', '%d', '%d', '%s', '%d', '%d',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function CalibInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function CalibInfo:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.calibration_enable_1,
                                                    data_table.calibration_enable_2,
                                                    data_table.calibration_working,
                                                    data_table.has_value,
                                                    data_table.temperature_calibrated_n,
                                                    data_table.mac_address,
                                                    data_table.info_n_runs_per,
                                                    data_table.info_n_runs,
                                                    data_table.temperature,
                                                    data_table.calibration_sum,
                                                    data_table.temperature_oat,
                                                    data_table.temperature_calibrated_min,
                                                    data_table.temperature_calibrated_max,
                                                    os.time()))
end

function CalibInfo:delete(table_name, data_table)
    return nil
end


return CalibInfo
