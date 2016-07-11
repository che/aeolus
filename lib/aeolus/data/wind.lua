
local Wind = {}


Wind.ID = 73
Wind.SIZE = 32
Wind.NAME = 'wind'


function Wind:read(byte_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = data_cls:timestamp(byte_data:sub(9, 16))

    -- Wind magnitude
    data.wind_magnitude = data_cls:float(byte_data:sub(17, 20))

    -- Wind direction
    data.wind_direction = data_cls:float(byte_data:sub(21, 24))

    byte_data = nil

    return data
end


return Wind
