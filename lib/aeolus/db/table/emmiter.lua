
local Emmiter = {}


require('aeolus/log')


Emmiter.NAME = 'emmiter'


local _emmiter_cache = {}

local _table_exists = false

local _SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS emmiter (
        mac_address VARCHAR(17) NOT NULL,
        ip VARCHAR(15) NOT NULL,
        port INTEGER(5) NOT NULL,
        created_at FLOAT(8) NOT NULL,
        UNIQUE (mac_address));
]]

local _SQL_INSERT = [[
    INSERT INTO emmiter (mac_address, ip, port, created_at)
                        VALUES ('%s', '%s', '%d', '%.8f');
]]

local _SQL_SELECT = [[
    SELECT * FROM emmiter WHERE mac_address = '%s' LIMIT 1;
]]

local _SQL_DELETE = [[
    DELETE FROM emmiter WHERE mac_address = '%s';
]]

local _SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS emmiter;
]]

local _STR_KEY_ALL = 'a'


function Emmiter:exists(mac_address)
    for i = 1, #_emmiter_cache do
        if _emmiter_cache[i] == mac_address then
            return true
        end
    end

    return false
end

function Emmiter:table_exists()
    return _table_exists
end

function Emmiter:exists_in_table(mac_address)
    local cursor, error_message = self:driver():execute(_SQL_SELECT, mac_address)

    if error_message or cursor == nil then
        Log:debug(('DB Emmiter: emmiter %s does not exist in table: %s'):format(mac_address, error_message))

        return false
    end

    if cursor:fetch({}, _STR_KEY_ALL) == nil then
        cursor:close()
        Log:debug(('DB Emmiter: emmiter %s does not exist in table'):format(mac_address))

        return false
    else
        cursor:close()
        table.insert(_emmiter_cache, mac_address)
        Log:debug(('DB Emmiter: emmiter %s exists in table'):format(mac_address))
    end

    return true
end

function Emmiter:table_create()
    local status, error_message = self:driver():execute(_SQL_TABLE_CREATE)

    if error_message then
        Log:warn(('DB Emmiter: table emmiter was not created: %s'):format(error_message))

        return false
    end

    _table_exists = true
    Log:debug('DB Emmiter: table emmiter was created')

    return true
end

function Emmiter:insert(data_table)
    if not self:exists_in_table(data_table.mac_address) then
        local status, error_message = self:driver():execute(_SQL_INSERT:format(
                                                            data_table.mac_address,
                                                            data_table.ip,
                                                            data_table.port,
                                                            os.time()))

        if error_message then
            Log:warn(('DB Emmiter: emmiter %s was not inserted: %s'):format(data_table.mac_address, error_message))
            return false
        end
    end

    table.insert(_emmiter_cache, data_table.mac_address)
    Log:debug(('DB Emmiter: emmiter %s was inserted'):format(data_table.mac_address))

    return true
end

function Emmiter:delete(mac_address)
    if self:exists_in_table(mac_address) then
        local status, error_message = self:driver():execute(_SQL_DELETE, mac_address)

        if error_message then
            Log:warn(('DB Emmiter: emmiter %s was not deleted: %s'):format(mac_address, error_message))
            return false
        end
    end

    for id, value in pairs(_emmiter_cache) do
        if value == mac_address then
            table.remove(_emmiter_cache, id)
            break
        end
    end
    Log:debug(('DB Emmiter: emmiter %s was deleted'):format(mac_address))

    return true
end

function Emmiter:table_delete()
    local status, error_message = self:driver():execute(_SQL_TABLE_DELETE)

    if error_message then
        Log:warn(('DB Emmiter: table emmiter was not deleted: %s'):format(error_message))
        return false
    end

    _table_exists = false
    Log:debug('DB Emmiter: table emmiter was deleted')

    return true
end


return Emmiter
