
local Data = {}


require('aeolus/log')


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


local _data_cache = {}
local _DATA_CACHE_TYPE = 'table'

local _STR_TABLE_NAME = '%s%s_%s'

local _SQL_TABLE_CREATE = [[
    CREATE TABLE IF NOT EXISTS %s (
%s);
]]

local _SQL_TABLE_DELETE = [[
    DROP TABLE IF EXISTS %s;
]]


local function _data_cache_add(mac_address, data_type)
    local _mac = nil

    for mac, list_data in pairs(_data_cache) do
        if mac == mac_address and type(list_data) == _DATA_CACHE_TYPE then
            _mac = mac
            list_data[#list_data + 1] = data_type
            break
        end
    end

    if _mac == nil then
        _data_cache[mac_address] = {}
        table.insert(_data_cache[mac_address], data_type)
    end
end

local function _data_cache_delete(mac_address, data_type)
    for mac, list_data in pairs(_data_cache) do
        if mac == mac_address and type(list_data) == _DATA_CACHE_TYPE then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    table.remove(list_data, i)
                    break
                end
            end

            if #list_data == 0 then
                for i, value in ipairs(_data_cache) do
                    if value == mac_address then
                        table.remove(_data_cache, i)
                        break
                    end
                end
            end

            break
        end
    end
end

local function _sql_create_table(data_type, table_name)
    return _SQL_TABLE_CREATE:format(table_name, Data.map[data_type]:sql_table_structure())
end


function Data:table_exists(mac_address, data_type)
    for mac, list_data in pairs(_data_cache) do
        if mac == mac_address and type(list_data) == _DATA_CACHE_TYPE then
            for i = 1, #list_data do
                if list_data[i] == data_type then
                    return true
                end
            end
        end
    end

    return false
end

function Data:table_create(driver_obj, mac_address, data_type)
    local table_name = self:table_name(mac_address, data_type)
    local status, error_message = driver_obj:execute(_sql_create_table(data_type, table_name))

    if error_message then
        Log:warn(('DB Data: table %s was not created: %s'):format(table_name, error_message))
        return false
    end

    _data_cache_add(mac_address, data_type)
    Log:debug(('DB Data: table %s was created'):format(table_name))

    return true
end

function Data:insert(driver_obj, mac_address, data_type, data_table)
    local table_name = self:table_name(mac_address, data_type)
    Log:debug(('DB Data: inserting data in table %s...'):format(table_name))

    return self.map[data_type]:insert(driver_obj, table_name, data_table)
end

function Data:delete(driver_obj, mac_address, data_type, data_table)
    local table_name = self:table_name(mac_address, data_type)
    Log:debug(('DB Data: deleting data in table %s...'):format(table_name))

    return self.map[data_type]:delete(driver_obj, table_name, data_table)
end

function Data:table_delete(driver_obj, mac_address, data_type)
    local table_name = self:table_name(mac_address, data_type)
    local status, error_message = driver_obj:execute(_SQL_TABLE_DELETE:format(table_name))

    if error_message then
        Log:warn(('DB Data: table %s was not deleted: %s'):format(table_name, error_message))
        return false
    end

    _data_cache_delete(mac_address, data_type)
    Log:debug(('DB Data: table %s was deleted'):format(table_name))

    return true
end

function Data:table_name(mac_address, data_type)
    return _STR_TABLE_NAME:format(self.NAME, mac_address, data_type)
end


return Data
