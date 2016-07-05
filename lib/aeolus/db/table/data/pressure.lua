
local Pressure = {}


Pressure.NAME = 'pressure'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        static_pressure FLOAT(4) NOT NULL,
        pilot_pressure FLOAT(4) NOT NULL,
        airspeed FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        static_pressure,
        pilot_pressure,
        airspeed,
        created_at)
        VALUES ('%d', '%.8f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function Pressure:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Pressure:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.data_valid,
                                                data_table.timestamp,
                                                data_table.static_pressure,
                                                data_table.pilot_pressure,
                                                data_table.airspeed,
                                                os.time()))
end

function Pressure:delete(driver_obj, table_name, data_table)
    return nil
end


return Pressure
