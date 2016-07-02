
local Magnet = {}


Magnet.ID = 64
Magnet.SIZE = 32 * 2
Magnet.NAME = 'magnet'


function Magnet:read(hex_data)
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

    -- Magnetometer X
    data.magnetometer_x = hex_data:sub(33, 40)
print(data.magnetometer_x)

    -- Magnetometer Y
    data.magnetometer_y = hex_data:sub(41, 48)
print(data.magnetometer_y)

    -- Magnetometer Z
    data.magnetometer_z = hex_data:sub(49, 56)
print(data.magnetometer_z)

    hex_data = nil

    return data
end


return Magnet
