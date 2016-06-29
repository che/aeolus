
local Pressure = {}


Pressure.NAME = 'pressure'


local SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp TIMESTAMP NOT NULL,
        static_pressure FLOAT(16) NOT NULL,
        pilot_pressure FLOAT(16) NOT NULL,
        airspeed FLOAT(16) NOT NULL,
]]


function Pressure:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Pressure:insert(driver_obj, table_name, data_table)
    return nil
end

function Pressure:delete(driver_obj, table_name, data_table)
    return nil
end


return Pressure
