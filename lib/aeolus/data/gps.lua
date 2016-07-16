
-- GPS readings

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

    -- GPS timestamp hour
    data.gps_timestamp_hour = byte_data:byte(4)

    -- GPS timestamp min
    data.gps_timestamp_min = byte_data:byte(5)

    -- GPS timestamp sec
    data.gps_timestamp_sec = byte_data:byte(6)

    -- GPS timestamp msec mod
    data.gps_timestamp_msec_mod = byte_data:byte(7)

    -- GPS timestamp msec div
    data.gps_timestamp_msec_div = byte_data:byte(8)

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

    -- GPS bearing
    data.gps_bearing = self:float(byte_data:sub(33, 36))

    byte_data = nil

    return data
end


return GPS
