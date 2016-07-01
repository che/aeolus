
local Pressure = {}


Pressure.ID = 61
Pressure.SIZE = 32
Pressure.NAME = 'pressure'


function Pressure:read(hex_data)
    local data = {}

print(self.NAME)
print(hex_data)

    -- Data valid
    data.data_valid = string.sub(hex_data, 1, 2)
print(data.data_valid)

    -- Timestamp
    data.timestamp = string.sub(hex_data, 17, 32)
print(data.timestamp)

    -- Static pressure
    data.static_pressure = string.sub(hex_data, 33, 40)
print(data.static_pressure)

    -- Pilot pressure
    data.pilot_pressure = string.sub(hex_data, 41, 48)
print(data.pilot_pressure)

    -- Airspeed
    data.airspeed = string.sub(hex_data, 49, 56)
print(data.airspeed)

    hex_data = nil

    return data
end


return Pressure
