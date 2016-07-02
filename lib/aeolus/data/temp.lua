
local Temp = {}


Temp.ID = 65
Temp.SIZE = 32 * 2
Temp.NAME = 'temp'


function Temp:read(hex_data)
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

    -- Temperature
    data.temperature = hex_data:sub(33, 40)
print(data.temperature)

    hex_data = nil

    return data
end


return Temp
