
local Attitude = {}


Attitude.NAME = 'attitude'


local SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        attitude_roll FLOAT(16) NOT NULL,
        attitude_pitch FLOAT(16) NOT NULL,
        attitude_yaw FLOAT(16) NOT NULL,
        slip_ball_indication FLOAT(16) NOT NULL,
        turn_coordinator_indication FLOAT(16) NOT NULL,
        attitude_quaternion_qx FLOAT(16) NOT NULL,
        attitude_quaternion_qy FLOAT(16) NOT NULL,
        attitude_quaternion_qz FLOAT(16) NOT NULL,
        attitude_quaternion_qw FLOAT(16) NOT NULL,
]]


function Attitude:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Attitude:insert(driver_obj, table_name, data_table)
    return nil
end

function Attitude:delete(driver_obj, table_name, data_table)
    return nil
end


return Attitude
