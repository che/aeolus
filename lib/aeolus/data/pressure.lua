
local Pressure = {}


Pressure.ID = 61
Pressure.SIZE = 32 * 2
Pressure.NAME = 'pressure'


function Pressure:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Timestamp
    data.timestamp = data_cls:timestamp(hex_data:sub(17, 32))

    -- Static pressure
    data.static_pressure = data_cls:float(hex_data:sub(33, 40))

    -- Pilot pressure
    data.pilot_pressure = data_cls:float(hex_data:sub(41, 48))

    -- Airspeed
    data.airspeed = data_cls:float(hex_data:sub(49, 56))

    hex_data = nil

    return data
end


return Pressure
