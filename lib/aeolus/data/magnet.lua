
local Magnet = {}


Magnet.ID = 64
Magnet.SIZE = 32 * 2
Magnet.NAME = 'magnet'


function Magnet:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Magnetometer X
    data.magnetometer_x = data_cls:float(hex_data:sub(33, 40))

    -- Magnetometer Y
    data.magnetometer_y = data_cls:float(hex_data:sub(41, 48))

    -- Magnetometer Z
    data.magnetometer_z = data_cls:float(hex_data:sub(49, 56))

    hex_data = nil

    return data
end


return Magnet
