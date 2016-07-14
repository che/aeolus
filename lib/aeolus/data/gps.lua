
local GPS = {}


GPS.ID = 66
GPS.SIZE = 36
GPS.NAME = 'gps'


function GPS:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Has fix
    data.has_fix = byte_data:byte(2)

    -- Number of satellites
    data.number_of_satellites = byte_data:byte(3)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Latitude
    data.latitude = self:float(byte_data:sub(17, 20))

    -- Longitude
    data.longitude = self:float(byte_data:sub(21, 24))

    -- Altitude
    data.altitude = self:float(byte_data:sub(25, 28))

    -- Ground speed
    data.ground_speed = self:float(byte_data:sub(29, 32))

    -- Bearing
    data.bearing = self:float(byte_data:sub(33, 36))

    byte_data = nil

    return data
end


return GPS
