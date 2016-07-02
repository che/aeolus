
local Gyro = {}


Gyro.ID = 62
Gyro.SIZE = 32 * 2
Gyro.NAME = 'gyro'


function Gyro:read(hex_data)
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

    -- Gyro X
    data.gyro_x = hex_data:sub(33, 40)
print(data.gyro_x)

    -- Gyro Y
    data.gyro_y = hex_data:sub(41, 48)
print(data.gyro_y)

    -- Gyro Z
    data.gyro_z = hex_data:sub(49, 56)
print(data.gyro_z)

    hex_data = nil

    return data
end


return Gyro
