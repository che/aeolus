
local Emmiter = {}


Emmiter.NAME = 'emmiter'


local emmiter_cache = {}

local table_exists = false

local SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS emmiter (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        protocol VARCHAR(3) NOT NULL,
        source_mac VARCHAR(17) NOT NULL,
        source_ipv4 VARCHAR(15) NOT NULL,
        source_port INTEGER NOT NULL,
        destination_mac VARCHAR(17) NOT NULL,
        destination_ipv4 VARCHAR(15) NOT NULL,
        destination_port INTEGER NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
        UNIQUE(source_mac));
]]

local SQL_INSERT = [[
    INSERT INTO emmiter (protocol,
                        source_mac,
                        source_ipv4,
                        source_port,
                        destination_mac,
                        destination_ipv4,
                        destination_port)
                VALUES('%s', '%s', '%s', '%d', '%s', '%s', '%d')
]]

local SQL_SELECT = [[
    SELECT * FROM emmiter WHERE source_mac = '%s' LIMIT 1
]]

local SQL_DELETE = [[
    DELETE FROM emmiter WHERE source_mac = '%s'
]]

local SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS emmiter;
]]


function Emmiter:exists(source_mac)
    for i = 1, #emmiter_cache do
        if emmiter_cache[i] == source_mac then
            return true
        end
    end

    return false
end

function Emmiter:table_exists()
    return table_exists
end

function Emmiter:exists_in_table(driver_obj, source_mac)
    local cursor, error_message = driver_obj:execute(SQL_SELECT, source_mac)
--    print(cursor, error_message)

    if not nil == error_message or cursor == nil then
        return false
    end

    if cursor:fetch({}, 'a') == nil then
        cursor:close()
        return false
    else
        cursor:close()
        table.insert(emmiter_cache, source_mac)
    end

    return true
end

function Emmiter:table_create(driver_obj)
    local status, error_message = driver_obj:execute(SQL_TABLE_CREATE)

    if not nil == error_message then
        return false
    end

    table_exists = true

    return table_exists
end

function Emmiter:insert(driver_obj, values)
    if not self:exists_in_table(driver_obj, values[2]) then
        local status, error_message = driver_obj:execute(SQL_INSERT, values[1], values[2], values[3], values[4], values[5], values[6], values[7])
--        print(status, error_message)

        if not nil == error_message then
            return false
        end
    end

    table.insert(emmiter_cache, values[2])

    return true
end

function Emmiter:delete(driver_obj, source_mac)
    if self:exists_in_table(driver_obj, source_mac) then
        local status, error_message = driver_obj:execute(SQL_DELETE, source_mac)
--        print(status, error_message)

        if not nil == error_message then
            return false
        end
    end

    for id, value in pairs(emmiter_cache) do
        if value == source_mac then
            table.remove(emmiter_cache, id)
            break
        end
    end

    return true
end

function Emmiter:table_delete(driver_obj)
    local status, error_message = driver_obj:execute(SQL_TABLE_DELETE)

    if not nil == error_message then
        return false
    end

    table_exists = false

    return table_exists
end


return Emmiter
