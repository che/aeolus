
local Info = {}


Info.NAME = 'info'


local _SQL_TABLE_STRUCTURE = [[
        year VARCHAR(4) NOT NULL,
        month VARCHAR(2) NOT NULL,
        day VARCHAR(2) NOT NULL,
        hour VARCHAR(2) NOT NULL,
        minute VARCHAR(2) NOT NULL,
        second VARCHAR(2) NOT NULL,
        qnh FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]


function Info:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Info:insert(table_name, data_table)
    return nil
end

function Info:delete(table_name, data_table)
    return nil
end


return Info
