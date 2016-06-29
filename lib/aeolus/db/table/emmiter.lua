
local emmiter = {}


emmiter.NAME = 'emmiter'

emmiter.list = {}

emmiter.table_exists = false

emmiter.SQL_TABLE_CREATE = [[
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

emmiter.SQL_INSERT = [[
    INSERT INTO emmiter (protocol,
                        source_mac,
                        source_ipv4,
                        source_port,
                        destination_mac,
                        destination_ipv4,
                        destination_port)
                VALUES('%s', '%s', '%s', '%d', '%s', '%s', '%d')
]]

emmiter.SQL_SELECT = [[
    SELECT * FROM emmiter WHERE source_mac = '%s' LIMIT 1
]]

emmiter.SQL_DELETE = [[
    DELETE FROM emmiter WHERE source_mac = '%s'
]]

emmiter.SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS emmiter;
]]


function emmiter.exists(source_mac)
    for i = 1, #emmiter.list do
        if emmiter.list[i] == source_mac then
            return true
        end
    end

    return false
end

function emmiter.exists_in_table(driver_obj, source_mac)
    local cursor, error_message = driver_obj:execute(emmiter.SQL_SELECT, source_mac)
--    print(cursor, error_message)

    if not nil == error_message or cursor == nil then
        return false
    end

    if cursor:fetch({}, 'a') == nil then
        cursor:close()
        return false
    else
        cursor:close()
        table.insert(emmiter.list, source_mac)
    end

    return true
end

function emmiter:table_create(driver_obj)
    if self.table_exists == false then
        local status, error_message = driver_obj:execute(self.SQL_TABLE_CREATE)

        if not nil == error_message then
            return false
        end

        self.table_exists = true
    end

    return true
end

function emmiter:insert(driver_obj, values)
    if self.exists(values[2]) == false and self.exists_in_table(driver_obj, values[2]) == false then
        local status, error_message = driver_obj:execute(self.SQL_INSERT, values[1], values[2], values[3], values[4], values[5], values[6], values[7])
--        print(status, error_message)

        if not nil == error_message then
            return false
        end

        table.insert(self.list, values[2])
    end

    return true
end

function emmiter:delete(driver_obj, source_mac)
    if self.exists(source_mac) == true or self.exists_in_table(driver_obj, source_mac) == true then
        local status, error_message = driver_obj:execute(self.SQL_DELETE, source_mac)
--        print(status, error_message)

        if not nil == error_message then
            return false
        end

        for id, value in pairs(self.list) do
            if value == source_mac then
                table.remove(self.list, id)
                break
            end
        end
    end

    return true
end

function emmiter:table_delete(driver_obj)
    if self.table_exists == true then
        local status, error_message = driver_obj:execute(self.SQL_TABLE_DELETE)

        if not nil == error_message then
            return false
        end

        self.table_exists = false
    end

    return true
end


return emmiter
