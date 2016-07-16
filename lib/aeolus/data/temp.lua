
-- Outside air temperature

local Temp = {}


Temp.ID = 65
Temp.SIZE = 32
Temp.NAME = 'temp'


function Temp:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Temperature
    data.temperature = self:float(byte_data:sub(17, 20))

    byte_data = nil

    return data
end


return Temp
