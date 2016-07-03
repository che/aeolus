
local Attitude = {}


Attitude.ID = 71
Attitude.SIZE = 52 * 2
Attitude.NAME = 'attitude'


function Attitude:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:double(hex_data:sub(17, 32))

    -- Attitude: Roll
    data.attitude_roll = data_cls:float(hex_data:sub(33, 40))

    -- Attitude: Pitch
    data.attitude_pitch = data_cls:float(hex_data:sub(41, 48))

    -- Attitude: Yaw
    data.attitude_yaw = data_cls:float(hex_data:sub(49, 56))

    -- Slip ball indication
    data.slip_ball_indication = data_cls:float(hex_data:sub(57, 64))

    -- Turn cordinator indication
    data.turn_cordinator_indication = data_cls:float(hex_data:sub(65, 72))

    -- Attitude: Quaternoin qx
    data.attitude_quaternoin_qx = data_cls:float(hex_data:sub(73, 80))

    -- Attitude: Quaternoin qy
    data.attitude_quaternoin_qy = data_cls:float(hex_data:sub(81, 88))

    -- Attitude: Quaternoin qz
    data.attitude_quaternoin_qz = data_cls:float(hex_data:sub(89, 96))

    -- Attitude: Quaternoin qw
    data.attitude_quaternoin_qw = data_cls:float(hex_data:sub(97, 104))

    hex_data = nil

    return data
end


return Attitude
