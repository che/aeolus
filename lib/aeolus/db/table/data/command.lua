
local Command = {}


Command.NAME = 'command'


local _SQL_TABLE_STRUCTURE = [[
        message VARCHAR(256)
]]


function Command:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function Command:insert(table_name, data_table)
    return nil
end

function Command:delete(table_name, data_table)
    return nil
end


return Command
