
-- Pilot-Static pressure derived information

local Pressure = {}


Pressure.ID = 61
Pressure.SIZE = 36
Pressure.NAME = 'pressure'


function Pressure:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Static pressure
    data.static_pressure = self:float(byte_data:sub(17, 20))

    -- Pilot pressure
    data.pilot_pressure = self:float(byte_data:sub(21, 24))

    -- Airspeed
    data.airspeed = self:float(byte_data:sub(25, 28))

    -- QNH - current settings
    data.qnh_current_settings = self:float(byte_data:sub(29, 32))

    -- Altitude
    data.altitude = self:float(byte_data:sub(33, 36))

    byte_data = nil

    return data
end


return Pressure
