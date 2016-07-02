
local Accel = {}


Accel.ID = 63
Accel.SIZE = 40 * 2
Accel.NAME = 'accel'


function Accel:read(hex_data)
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

    -- Accelerometer X
    data.accelerometer_x = hex_data:sub(33, 40)
print(data.accelerometer_x)

    -- Accelerometer Y
    data.accelerometer_y = hex_data:sub(41, 48)
print(data.accelerometer_y)

    -- Accelerometer Z
    data.accelerometer_z = hex_data:sub(49, 56)
print(data.accelerometer_z)

    hex_data = nil

    return data
end


return Accel
