
local AeolusInfo = {}


AeolusInfo.NAME = 'aeolusinfo'


local SQL_TABLE_STRUCTURE = [[
        aeolus_model INTEGER NOT NULL,
        firmware_version VARCHAR(10) NOT NULL,
        mac_address VARCHAR(17) NOT NULL,
]]


function AeolusInfo:sql_table_structure()
    return SQL_TABLE_STRUCTURE
end

function AeolusInfo:insert(driver_obj, table_name, data_table)
    return nil
end

function AeolusInfo:delete(driver_obj, table_name, data_table)
    return nil
end


return AeolusInfo
