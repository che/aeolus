
local Data = {}


Data.NAME = 'data_'

Data.map = {}
Data.map['accel'] = require('aeolus/db/table/data/accel')
Data.map['aeolusinfo'] = require('aeolus/db/table/data/aeolusinfo')
Data.map['attitude'] = require('aeolus/db/table/data/attitude')
Data.map['calibinfo'] = require('aeolus/db/table/data/calibinfo')
Data.map['command'] = require('aeolus/db/table/data/command')
Data.map['compass'] = require('aeolus/db/table/data/compass')
Data.map['debuginfo'] = require('aeolus/db/table/data/debuginfo')
Data.map['gps'] = require('aeolus/db/table/data/gps')
Data.map['gyro'] = require('aeolus/db/table/data/gyro')
Data.map['log'] = require('aeolus/db/table/data/log')
Data.map['magnet'] = require('aeolus/db/table/data/magnet')
Data.map['pressure'] = require('aeolus/db/table/data/pressure')
Data.map['settime'] = require('aeolus/db/table/data/settime')
Data.map['temp'] = require('aeolus/db/table/data/temp')
Data.map['toast'] = require('aeolus/db/table/data/toast')
Data.map['wind'] = require('aeolus/db/table/data/wind')


local data_cache = {}
local data_cache_type = 'table'


local SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS %s (
%s        crc VARCHAR(4) NOT NULL,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL);
]]

local SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS %s;
]]


local function data_cache_add(source_mac, data_type)
    local _mac = nil

    for mac, list_data in pairs(data_cache) do
        if mac == source_mac and type(list_data) == data_cache_type then
            _mac = mac
            list_data[#list_data + 1] = data_type
            break
        end
    end

    if _mac == nil then
        data_cache[source_mac] = {}
        table.insert(data_cache[source_mac], data_type)
    end
end

local function data_cache_delete(source_mac, data_type)
    for mac, list_data in pairs(data_cache) do
        if mac == source_mac and type(list_data) == data_cache_type then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    table.remove(list_data, i)
                    break
                end
            end

            if #list_data == 0 then
                for i, value in ipairs(data_cache) do
                    if value == source_mac then
                        table.remove(data_cache, i)
                        break
                    end
                end
            end

            break
        end
    end
end

local function sql_create_table(data_type, table_name)
    return string.format(SQL_TABLE_CREATE, table_name, Data.map[data_type]:sql_table_structure())
end


function Data:table_exists(source_mac, data_type)
    for mac, list_data in pairs(data_cache) do
        if mac == source_mac and type(list_data) == data_cache_type then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    return true
                end
            end
        end
    end

    return false
end

function Data:table_create(driver_obj, source_mac, data_type)
    local table_name = self:table_name(source_mac, data_type)
    local status, error_message = driver_obj:execute(sql_create_table(data_type, table_name))

    if not nil == error_message then
        return false
    end

    data_cache_add(source_mac, data_type)

    return true
end

function Data:insert(driver_obj, source_mac, data_type, data_table)
    local table_name = self:table_name(source_mac, data_type)

    self.map[data_type]:insert(driver_obj, table_name, data_table)
end

function Data:delete(driver_obj, source_mac, data_type, data_table)
    local table_name = self:table_name(source_mac, data_type)

    self.map[data_type]:delete(driver_obj, table_name, data_table)
end

function Data:table_delete(driver_obj, source_mac, data_type)
    local table_name = self:table_name(source_mac, data_type)
    local status, error_message = driver_obj:execute(string.format(SQL_TABLE_DELETE, table_name))

    if not nil == error_message then
        return false
    end

    data_cache_delete(source_mac, data_type)

    return true
end

function Data:table_name(source_mac, data_type)
    return string.format('%s%s_%s', self.NAME, string.gsub(source_mac, ':', ''), data_type)
end


return Data
