
local Pressure = {}


Pressure.ID = 61

Pressure.NAME = 'pressure'


local struc_string = '%s%s'


function Pressure:read(data_array)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(data_array[1], 16)
    for i = 1, 8 do
        table.remove(data_array, 1)
    end
print(data.data_valid)

    -- Timestamp
    data.timestamp = ''
    for i = 1, 8 do
        data.timestamp = string.format(struc_string, data.timestamp, table.remove(data_array, 1))
    end
print(data.timestamp)

    -- Static pressure
    data.static_pressure = ''
    for i = 1, 4 do
        data.static_pressure = string.format(struc_string, data.static_pressure, table.remove(data_array, 1))
    end
print(data.static_pressure)

    -- Pilot pressure
    data.pilot_pressure = ''
    for i = 1, 4 do
        data.pilot_pressure = string.format(struc_string, data.pilot_pressure, table.remove(data_array, 1))
    end
print(data.pilot_pressure)

    -- Airspeed
    data.airspeed = ''
    for i = 1, 4 do
        data.airspeed = string.format(struc_string, data.airspeed, table.remove(data_array, 1))
    end
print(data.airspeed)

    data_array = nil

    return data
end


return Pressure
