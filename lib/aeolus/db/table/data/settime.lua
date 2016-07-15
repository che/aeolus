
local SetTime = {}


SetTime.NAME = 'settime'


local _SQL_TABLE_STRUCTURE = [[
        year VARCHAR(4) NOT NULL,
        month VARCHAR(2) NOT NULL,
        day VARCHAR(2) NOT NULL,
        hour VARCHAR(2) NOT NULL,
        minute VARCHAR(2) NOT NULL,
        second VARCHAR(2) NOT NULL
]]


function SetTime:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function SetTime:insert(table_name, data_table)
    return nil
end

function SetTime:delete(table_name, data_table)
    return nil
end


return SetTime
