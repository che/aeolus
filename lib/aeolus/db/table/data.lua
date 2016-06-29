
local data = {}


data.NAME = 'data_'

data.list = {}

data.list_type = 'table'

data.map = {}
data.map['accel'] = require('aeolus/db/table/data/accel')
data.map['aeolusinfo'] = require('aeolus/db/table/data/aeolusinfo')
data.map['attitude'] = require('aeolus/db/table/data/attitude')
data.map['calibinfo'] = require('aeolus/db/table/data/calibinfo')
data.map['command'] = require('aeolus/db/table/data/command')
data.map['compass'] = require('aeolus/db/table/data/compass')
data.map['debuginfo'] = require('aeolus/db/table/data/debuginfo')
data.map['gps'] = require('aeolus/db/table/data/gps')
data.map['gyro'] = require('aeolus/db/table/data/gyro')
data.map['log'] = require('aeolus/db/table/data/log')
data.map['magnet'] = require('aeolus/db/table/data/magnet')
data.map['pressure'] = require('aeolus/db/table/data/pressure')
data.map['settime'] = require('aeolus/db/table/data/settime')
data.map['temp'] = require('aeolus/db/table/data/temp')
data.map['toast'] = require('aeolus/db/table/data/toast')
data.map['wind'] = require('aeolus/db/table/data/wind')

data.SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS %s (id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        message_id INTEGER NOT NULL,
        crc VARCHAR(4) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL);
]]

data.SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS %s;
]]


local function data_list_add(source_mac, data_type)
    local _mac = nil

    for mac, list_data in pairs(data.list) do
        if mac == source_mac and type(list_data) == data.list_type then
            _mac = mac
            list_data[#list_data + 1] = data_type
            break
        end
    end

    if _mac == nil then
        data.list[source_mac] = {}
        table.insert(data.list[source_mac], data_type)
    end
end

local function data_list_delete(source_mac, data_type)
    for mac, list_data in pairs(data.list) do
        if mac == source_mac and type(list_data) == data.list_type then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    table.remove(list_data, i)
                    break
                end
            end

            if #list_data == 0 then
                for i, value in ipairs(data.list) do
                    if value == source_mac then
                        table.remove(data.list, i)
                        break
                    end
                end
            end

            break
        end
    end
end


function data.exists(source_mac, data_type)
    for mac, list_data in pairs(data.list) do
        if mac == source_mac and type(list_data) == data.list_type then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    return true
                end
            end
        end
    end

    return false
end

function data:table_create(driver_obj, source_mac, data_type)
    if self.exists(source_mac, data_type) == false then
        local table_name = self:table_name(source_mac, data_type)
        local status, error_message = driver_obj:execute(string.format(self.SQL_TABLE_CREATE, table_name))

        if not nil == error_message then
            return false
        end

        data_list_add(source_mac, data_type)
    end

    return true
end

function data:insert(driver_obj, source_mac, data_type, data_table)
    local table_name = self:table_name(source_mac, data_type)

    self.map[data_type]:insert(driver_obj, table_name, data_table)
end

function data:delete(driver_obj, source_mac, data_type, data_table)
    local table_name = self:table_name(source_mac, data_type)

    self.map[data_type]:delete(driver_obj, table_name, data_table)
end

function data:table_delete(driver_obj, source_mac, data_type)
    if self.exists(source_mac, data_type) == true then
        local status, error_message = driver_obj:execute(self.SQL_TABLE_DELETE)

        if not nil == error_message then
            return false
        end

        data_list_delete(source_mac, data_type)
    end

    return true
end

function data:table_name(source_mac, data_type)
    return string.format('%s%s_%s', self.NAME, string.gsub(source_mac, ':', ''), data_type)
end


return data
