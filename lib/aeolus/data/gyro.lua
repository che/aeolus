
local Gyro = {}


Gyro.ID = 62
Gyro.SIZE = 32 * 2
Gyro.NAME = 'gyro'


function Gyro:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Gyro X
    data.gyro_x = data_cls:float(hex_data:sub(33, 40))

    -- Gyro Y
    data.gyro_y = data_cls:float(hex_data:sub(41, 48))

    -- Gyro Z
    data.gyro_z = data_cls:float(hex_data:sub(49, 56))

    hex_data = nil

    return data
end


return Gyro
