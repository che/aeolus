
local Accel = {}


Accel.ID = 63
Accel.SIZE = 40 * 2
Accel.NAME = 'accel'


function Accel:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Accelerometer X
    data.accelerometer_x = data_cls:float(hex_data:sub(33, 40))

    -- Accelerometer Y
    data.accelerometer_y = data_cls:float(hex_data:sub(41, 48))

    -- Accelerometer Z
    data.accelerometer_z = data_cls:float(hex_data:sub(49, 56))

    hex_data = nil

    return data
end


return Accel
