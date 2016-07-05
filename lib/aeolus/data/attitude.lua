
local Attitude = {}


Attitude.ID = 71
Attitude.SIZE = 52 * 2
Attitude.NAME = 'attitude'


function Attitude:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Attitude: Roll
    data.attitude_roll = data_cls:float(hex_data:sub(33, 40))

    -- Attitude: Pitch
    data.attitude_pitch = data_cls:float(hex_data:sub(41, 48))

    -- Attitude: Yaw
    data.attitude_yaw = data_cls:float(hex_data:sub(49, 56))

    -- Slip ball indication
    data.slip_ball_indication = data_cls:float(hex_data:sub(57, 64))

    -- Turn cordinator indication
    data.turn_coordinator_indication = data_cls:float(hex_data:sub(65, 72))

    -- Attitude: Quaternion qx
    data.attitude_quaternion_qx = data_cls:float(hex_data:sub(73, 80))

    -- Attitude: Quaternion qy
    data.attitude_quaternion_qy = data_cls:float(hex_data:sub(81, 88))

    -- Attitude: Quaternion qz
    data.attitude_quaternion_qz = data_cls:float(hex_data:sub(89, 96))

    -- Attitude: Quaternion qw
    data.attitude_quaternion_qw = data_cls:float(hex_data:sub(97, 104))

    hex_data = nil

    return data
end


return Attitude
