
local Toast = {}


Toast.NAME = 'toast'


local SQL_TABLE_STRUCTURE = [[
        null_terminated_string VARCHAR(256),
]]


function Toast:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function Toast:insert(driver_obj, table_name, data_table)
    return nil
end

function Toast:delete(driver_obj, table_name, data_table)
    return nil
end


return Toast
