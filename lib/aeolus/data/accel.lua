
local Accel = {}


Accel.ID = 63
Accel.SIZE = 40
Accel.NAME = 'accel'


function Accel:read(hex_data)
    local data = {}

print(self.NAME)
print(hex_data)

    -- Data valid
    data.data_valid = string.sub(hex_data, 1, 2)
print(data.data_valid)

    -- Timestamp
    data.timestamp = string.sub(hex_data, 17, 32)
print(data.timestamp)

    -- Accelerometer X
    data.accelerometer_x = string.sub(hex_data, 33, 40)
print(data.accelerometer_x)

    -- Accelerometer Y
    data.accelerometer_y = string.sub(hex_data, 41, 48)
print(data.accelerometer_y)

    -- Accelerometer Z
    data.accelerometer_z = string.sub(hex_data, 49, 56)
print(data.accelerometer_z)

    hex_data = nil

    return data
end


return Accel
