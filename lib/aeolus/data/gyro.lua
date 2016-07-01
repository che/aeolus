
local Gyro = {}


Gyro.ID = 62
Gyro.SIZE = 32
Gyro.NAME = 'gyro'


function Gyro:read(hex_data)
    local data = {}

print(self.NAME)
print(hex_data)

    -- Data valid
    data.data_valid = string.sub(hex_data, 1, 2)
print(data.data_valid)

    -- Timestamp
    data.timestamp = string.sub(hex_data, 17, 32)
print(data.timestamp)

    -- Gyro X
    data.gyro_x = string.sub(hex_data, 33, 40)
print(data.gyro_x)

    -- Gyro Y
    data.gyro_y = string.sub(hex_data, 41, 48)
print(data.gyro_y)

    -- Gyro Z
    data.gyro_z = string.sub(hex_data, 49, 56)
print(data.gyro_z)

    hex_data = nil

    return data
end


return Gyro
