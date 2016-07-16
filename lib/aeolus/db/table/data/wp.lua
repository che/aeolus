
local WP = {}


WP.NAME = 'wp'


local _SQL_TABLE_STRUCTURE = [[
        action INTEGER(1) NOT NULL,
        action_name VARCHAR(24) NOT NULL,
        target_point_index FLOAT(4) NOT NULL,
        latitude FLOAT(4) NOT NULL,
        longitude FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        action,
        action_name,
        target_point_index,
        latitude,
        longitude,
        created_at)
        VALUES ('%d', '%s', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function WP:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function WP:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    adata_table.ction,
                                                    adata_table.action_name,
                                                    adata_table.target_point_index,
                                                    adata_table.latitude,
                                                    adata_table.longitude,
                                                    os.time()))
end

function WP:delete(table_name, data_table)
    return nil
end


return WP
