
local Accel = {}


Accel.ID = 63
Accel.SIZE = 40
Accel.NAME = 'accel'


function Accel:read(byte_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = data_cls:timestamp(byte_data:sub(9, 16))

    -- Accelerometer X
    data.accelerometer_x = data_cls:float(byte_data:sub(17, 20))

    -- Accelerometer Y
    data.accelerometer_y = data_cls:float(byte_data:sub(21, 24))

    -- Accelerometer Z
    data.accelerometer_z = data_cls:float(byte_data:sub(25, 28))

    byte_data = nil

    return data
end


return Accel
