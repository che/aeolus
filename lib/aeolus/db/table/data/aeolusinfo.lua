
local AeolusInfo = {}


AeolusInfo.NAME = 'aeolusinfo'


local _SQL_TABLE_STRUCTURE = [[
        model_id INTEGER(2) NOT NULL,
        model_name VARCHAR(12) NOT NULL,
        firmware_version VARCHAR(8) NOT NULL,
        mac_address VARCHAR(17) NOT NULL,
        created_at FLOAT(8) NOT NULL,
        UNIQUE (model_id, mac_address, firmware_version)
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        model_id,
        model_name,
        firmware_version,
        mac_address,
        created_at)
        VALUES ('%d', '%s', '%s', '%s', '%.8f');
]]


function AeolusInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function AeolusInfo:insert(driver_obj, table_name, data_table)
    return driver_obj:execute(_SQL_INSERT:format(table_name,
                                                data_table.model_id,
                                                data_table.model_name,
                                                data_table.firmware_version,
                                                data_table.mac_address,
                                                os.time()))
end

function AeolusInfo:delete(driver_obj, table_name, data_table)
    return nil
end


return AeolusInfo
