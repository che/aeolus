
local Temp = {}


Temp.ID = 65
Temp.SIZE = 32 * 2
Temp.NAME = 'temp'


function Temp:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Temperature
    data.temperature = data_cls:float(hex_data:sub(33, 40))

    hex_data = nil

    return data
end


return Temp
