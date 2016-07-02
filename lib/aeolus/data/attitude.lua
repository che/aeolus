
local Attitude = {}


Attitude.ID = 71
Attitude.SIZE = 52 * 2
Attitude.NAME = 'attitude'


function Attitude:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)
print(data.data_valid)

    -- Timestamp
    data.timestamp = hex_data:sub(17, 32)
print(data.timestamp)

    -- Attitude: Roll
    data.attitude_roll = hex_data:sub(33, 40)
print(data.attitude_roll)

    -- Attitude: Pitch
    data.attitude_pitch = hex_data:sub(41, 48)
print(data.attitude_pitch)

    -- Attitude: Yaw
    data.attitude_yaw = hex_data:sub(49, 56)
print(data.attitude_yaw)

    -- Slip ball indication
    data.slip_ball_indication = hex_data:sub(57, 64)
print(data.slip_ball_indication)

    -- Turn cordinator indication
    data.turn_cordinator_indication = hex_data:sub(65, 72)
print(data.turn_cordinator_indication)

    -- Attitude: Quaternoin qx
    data.attitude_quaternoin_qx = hex_data:sub(73, 80)
print(data.attitude_quaternoin_qx)

    -- Attitude: Quaternoin qy
    data.attitude_quaternoin_qy = hex_data:sub(81, 88)
print(data.attitude_quaternoin_qy)

    -- Attitude: Quaternoin qz
    data.attitude_quaternoin_qz = hex_data:sub(89, 96)
print(data.attitude_quaternoin_qz)

    -- Attitude: Quaternoin qw
    data.attitude_quaternoin_qw = hex_data:sub(97, 104)
print(data.attitude_quaternoin_qw)

    hex_data = nil

    return data
end


return Attitude
