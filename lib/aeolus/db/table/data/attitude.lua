
local Attitude = {}


Attitude.NAME = 'attitude'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        attitude_roll FLOAT(4) NOT NULL,
        attitude_pitch FLOAT(4) NOT NULL,
        attitude_yaw FLOAT(4) NOT NULL,
        slip_ball_indication FLOAT(4) NOT NULL,
        turn_coordinator_indication FLOAT(4) NOT NULL,
        attitude_quaternion_qx FLOAT(4) NOT NULL,
        attitude_quaternion_qy FLOAT(4) NOT NULL,
        attitude_quaternion_qz FLOAT(4) NOT NULL,
        attitude_quaternion_qw FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        attitude_roll,
        attitude_pitch,
        attitude_yaw,
        slip_ball_indication,
        turn_coordinator_indication,
        attitude_quaternion_qx,
        attitude_quaternion_qy,
        attitude_quaternion_qz,
        attitude_quaternion_qw,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.8f');
]]


function Attitude:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Attitude:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.data_valid,
                                                data_table.timestamp,
                                                data_table.attitude_roll,
                                                data_table.attitude_pitch,
                                                data_table.attitude_yaw,
                                                data_table.slip_ball_indication,
                                                data_table.turn_coordinator_indication,
                                                data_table.attitude_quaternion_qx,
                                                data_table.attitude_quaternion_qy,
                                                data_table.attitude_quaternion_qz,
                                                data_table.attitude_quaternion_qw,
                                                os.time()))
end

function Attitude:delete(driver_obj, table_name, data_table)
    return nil
end


return Attitude
