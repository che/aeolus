
local SetTime = {}


SetTime.NAME = 'settime'


local SQL_TABLE_STRUCTURE = [[
        year VARCHAR(4) NOT NULL,
        month VARCHAR(2) NOT NULL,
        day VARCHAR(2) NOT NULL,
        hour VARCHAR(2) NOT NULL,
        minute VARCHAR(2) NOT NULL,
        second VARCHAR(2) NOT NULL,
]]


function SetTime:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function SetTime:insert(driver_obj, table_name, data_table)
    return nil
end

function SetTime:delete(driver_obj, table_name, data_table)
    return nil
end


return SetTime
