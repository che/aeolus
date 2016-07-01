
local Magnet = {}


Magnet.ID = 64
Magnet.SIZE = 32
Magnet.NAME = 'magnet'


function Magnet:read(hex_data)
    local data = {}

print(self.NAME)
print(hex_data)

    -- Data valid
    data.data_valid = string.sub(hex_data, 1, 2)
print(data.data_valid)

    -- Timestamp
    data.timestamp = string.sub(hex_data, 17, 32)
print(data.timestamp)

    -- Magnetometer X
    data.magnetometer_x = string.sub(hex_data, 33, 40)
print(data.magnetometer_x)

    -- Magnetometer Y
    data.magnetometer_y = string.sub(hex_data, 41, 48)
print(data.magnetometer_y)

    -- Magnetometer Z
    data.magnetometer_z = string.sub(hex_data, 49, 56)
print(data.magnetometer_z)

    hex_data = nil

    return data
end


return Magnet
