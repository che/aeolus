
-- Attitude information

local Attitude = {}


Attitude.ID = 71
Attitude.SIZE = 52
Attitude.NAME = 'attitude'


function Attitude:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Attitude: Roll
    data.attitude_roll = self:float(byte_data:sub(17, 20))

    -- Attitude: Pitch
    data.attitude_pitch = self:float(byte_data:sub(21, 24))

    -- Attitude: Yaw
    data.attitude_yaw = self:float(byte_data:sub(25, 28))

    -- Slip ball indication
    data.slip_ball_indication = self:float(byte_data:sub(29, 32))

    -- Turn cordinator indication
    data.turn_coordinator_indication = self:float(byte_data:sub(33, 36))

    -- Attitude: Quaternion qx
    data.attitude_quaternion_qx = self:float(byte_data:sub(37, 40))

    -- Attitude: Quaternion qy
    data.attitude_quaternion_qy = self:float(byte_data:sub(41, 44))

    -- Attitude: Quaternion qz
    data.attitude_quaternion_qz = self:float(byte_data:sub(45, 48))

    -- Attitude: Quaternion qw
    data.attitude_quaternion_qw = self:float(byte_data:sub(49, 52))

    byte_data = nil

    return data
end


return Attitude
