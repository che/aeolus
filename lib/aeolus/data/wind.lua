
local Wind = {}


Wind.ID = 73
Wind.SIZE = 32 * 2
Wind.NAME = 'wind'


function Wind:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:double(hex_data:sub(17, 32))

    -- Wind magnitude
    data.wind_magnitude = data_cls:float(hex_data:sub(33, 40))

    -- Wind direction
    data.wind_direction = data_cls:float(hex_data:sub(41, 48))

    hex_data = nil

    return data
end


return Wind
