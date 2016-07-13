
local Emmiter = {}


Emmiter.NAME = 'emmiter'


local _emmiter_cache = {}

local _table_exists = false

local _SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS emmiter (
        mac_address VARCHAR(17) NOT NULL,
        ip VARCHAR(15) NOT NULL,
        port INTEGER(5) NOT NULL,
        created_at FLOAT(8) NOT NULL,
        UNIQUE (mac_address, ip, port));
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

function Emmiter:exists_in_table(driver_obj, mac_address)
    local cursor, error_message = driver_obj:execute(_SQL_SELECT, mac_address)
--    print(cursor, error_message)

    if not nil == error_message or cursor == nil then
        return false
    end

    if cursor:fetch({}, _STR_KEY_ALL) == nil then
        cursor:close()

        return false
    else
        cursor:close()
        table.insert(_emmiter_cache, mac_address)
    end

    return true
end

function Emmiter:table_create(driver_obj)
    local status, error_message = driver_obj:execute(_SQL_TABLE_CREATE)

    if not nil == error_message then
        return false
    end

    _table_exists = true

    return true
end

function Emmiter:insert(driver_obj, data_table)
    if not self:exists_in_table(driver_obj, data_table.mac_address) then
        local status, error_message = driver_obj:execute(_SQL_INSERT:format(
                                                        data_table.mac_address,
                                                        data_table.ip,
                                                        data_table.port,
                                                        os.time()))
--        print(status, error_message)

        if not nil == error_message then
            return false
        end
    end

    table.insert(_emmiter_cache, data_table.mac_address)

    return true
end

function Emmiter:delete(driver_obj, mac_address)
    if self:exists_in_table(driver_obj, mac_address) then
        local status, error_message = driver_obj:execute(_SQL_DELETE, mac_address)
--        print(status, error_message)

        if not nil == error_message then
            return false
        end
    end

    for id, value in pairs(_emmiter_cache) do
        if value == mac_address then
            table.remove(_emmiter_cache, id)
            break
        end
    end

    return true
end

function Emmiter:table_delete(driver_obj)
    local status, error_message = driver_obj:execute(_SQL_TABLE_DELETE)

    if not nil == error_message then
        return false
    end

    _table_exists = false

    return true
end


return Emmiter
