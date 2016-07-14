
local Gyro = {}


Gyro.ID = 62
Gyro.SIZE = 32
Gyro.NAME = 'gyro'


function Gyro:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Gyro X
    data.gyro_x = self:float(byte_data:sub(17, 20))

    -- Gyro Y
    data.gyro_y = self:float(byte_data:sub(21, 24))

    -- Gyro Z
    data.gyro_z = self:float(byte_data:sub(25, 28))

    byte_data = nil

    return data
end


return Gyro
