
local Wind = {}


Wind.ID = 73
Wind.SIZE = 32 * 2
Wind.NAME = 'wind'


function Wind:read(hex_data)
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

    -- Wind magnitude
    data.wind_magnitude = hex_data:sub(33, 40)
print(data.wind_magnitude)

    -- Wind direction
    data.wind_direction = hex_data:sub(41, 48)
print(data.wind_direction)

    hex_data = nil

    return data
end


return Wind
