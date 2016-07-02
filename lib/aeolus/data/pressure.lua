
local Pressure = {}


Pressure.ID = 61
Pressure.SIZE = 32 * 2
Pressure.NAME = 'pressure'


function Pressure:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)
print(data.data_valid)

    -- Timestamp
    data.timestamp = hex_data:sub(17, 32)
print(data.timestamp)

    -- Static pressure
    data.static_pressure = hex_data:sub(33, 40)
print(data.static_pressure)

    -- Pilot pressure
    data.pilot_pressure = hex_data:sub(41, 48)
print(data.pilot_pressure)

    -- Airspeed
    data.airspeed = hex_data:sub(49, 56)
print(data.airspeed)

    hex_data = nil

    return data
end


return Pressure
