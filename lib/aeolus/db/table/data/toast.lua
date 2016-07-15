
local Toast = {}


Toast.NAME = 'toast'


local _SQL_TABLE_STRUCTURE = [[
        null_terminated_string VARCHAR(256)
]]


function Toast:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Toast:insert(table_name, data_table)
    return nil
end

function Toast:delete(table_name, data_table)
    return nil
end


return Toast
