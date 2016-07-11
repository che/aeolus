
local Pressure = {}


Pressure.ID = 61
Pressure.SIZE = 32
Pressure.NAME = 'pressure'


function Pressure:read(byte_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = data_cls:timestamp(byte_data:sub(9, 16))

    -- Static pressure
    data.static_pressure = data_cls:float(byte_data:sub(17, 20))

    -- Pilot pressure
    data.pilot_pressure = data_cls:float(byte_data:sub(21, 24))

    -- Airspeed
    data.airspeed = data_cls:float(byte_data:sub(25, 28))

    byte_data = nil

    return data
end


return Pressure
