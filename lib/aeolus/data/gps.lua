
local GPS = {}


GPS.ID = 66
GPS.SIZE = 36 * 2
GPS.NAME = 'gps'


function GPS:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)
print(data.data_valid)

    -- Has fix
    data.has_fix = tonumber(hex_data:sub(3, 4), 16)
print(data.has_fix)

    -- Number of satellites
    data.number_of_satellites = tonumber(hex_data:sub(5, 6), 16)
print(data.number_of_satellites)

    -- Timestamp
    data.timestamp = hex_data:sub(17, 32)
print(data.timestamp)

    -- Latitude
    data.latitude = hex_data:sub(33, 40)
print(data.latitude)

    -- Longitude
    data.longitude = hex_data:sub(41, 48)
print(data.longitude)

    -- Altitude
    data.altitude = hex_data:sub(49, 56)
print(data.altitude)

    -- Ground speed
    data.ground_speed = hex_data:sub(57, 64)
print(data.ground_speed)

    -- Something else
    data.something_else = hex_data:sub(65, 72)
print(data.something_else)

    hex_data = nil

    return data
end


return GPS
