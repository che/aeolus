
local Temp = {}


Temp.ID = 65
Temp.SIZE = 32
Temp.NAME = 'temp'


function Temp:read(byte_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = data_cls:timestamp(byte_data:sub(9, 16))

    -- Temperature
    data.temperature = data_cls:float(byte_data:sub(17, 20))

    byte_data = nil

    return data
end


return Temp
