
local GPS = {}


GPS.ID = 66
GPS.SIZE = 36 * 2
GPS.NAME = 'gps'


function GPS:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Has fix
    data.has_fix = tonumber(hex_data:sub(3, 4), 16)

    -- Number of satellites
    data.number_of_satellites = tonumber(hex_data:sub(5, 6), 16)

    -- Timestamp
    data.timestamp = data_cls:double(hex_data:sub(17, 32))

    -- Latitude
    data.latitude = data_cls:float(hex_data:sub(33, 40))

    -- Longitude
    data.longitude = data_cls:float(hex_data:sub(41, 48))

    -- Altitude
    data.altitude = data_cls:float(hex_data:sub(49, 56))

    -- Ground speed
    data.ground_speed = data_cls:float(hex_data:sub(57, 64))

    -- Something else
    data.something_else = data_cls:float(hex_data:sub(65, 72))

    hex_data = nil

    return data
end


return GPS
