
local Magnet = {}


Magnet.ID = 64
Magnet.SIZE = 32
Magnet.NAME = 'magnet'


function Magnet:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Magnetometer X
    data.magnetometer_x = self:float(byte_data:sub(17, 20))

    -- Magnetometer Y
    data.magnetometer_y = self:float(byte_data:sub(21, 24))

    -- Magnetometer Z
    data.magnetometer_z = self:float(byte_data:sub(25, 28))

    byte_data = nil

    return data
end


return Magnet
