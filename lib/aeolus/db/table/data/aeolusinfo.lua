
local AeolusInfo = {}


AeolusInfo.NAME = 'aeolusinfo'


local _SQL_TABLE_STRUCTURE = [[
        model_id INTEGER(2) NOT NULL,
        model_name VARCHAR(12) NOT NULL,
        firmware_version VARCHAR(8) NOT NULL,
        model VARCHAR(3) NOT NULL,
        mac_address VARCHAR(17) NOT NULL,
        number_of_reboots_mod INTEGER(3) NOT NULL,
        number_of_reboots_div INTEGER(3) NOT NULL,
        created_at FLOAT(8) NOT NULL,
        UNIQUE (model_id, mac_address, firmware_version)
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        model_id,
        model_name,
        firmware_version,
        model,
        mac_address,
        number_of_reboots_mod,
        number_of_reboots_div,
        created_at)
        VALUES ('%d', '%s', '%s', '%s', '%s', '%d', '%d', '%.8f');
]]


function AeolusInfo:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function AeolusInfo:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.model_id,
                                                    data_table.model_name,
                                                    data_table.firmware_version,
                                                    data_table.model,
                                                    data_table.mac_address,
                                                    data_table.number_of_reboots_mod,
                                                    data_table.number_of_reboots_div,
                                                    os.time()))
end

function AeolusInfo:delete(table_name, data_table)
    return nil
end


return AeolusInfo
