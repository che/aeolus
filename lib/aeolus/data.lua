
local Data = {}


Data.BLOCK_KEY = '7e'

Data.map = {}
Data.map[63] = require('aeolus/data/accel')
Data.map[51] = require('aeolus/data/aeolusinfo')
Data.map[71] = require('aeolus/data/attitude')
Data.map[75] = require('aeolus/data/calibinfo')
Data.map[11] = require('aeolus/data/command')
Data.map[72] = require('aeolus/data/compass')
Data.map[76] = require('aeolus/data/debuginfo')
Data.map[66] = require('aeolus/data/gps')
Data.map[62] = require('aeolus/data/gyro')
Data.map[81] = require('aeolus/data/log')
Data.map[64] = require('aeolus/data/magnet')
Data.map[61] = require('aeolus/data/pressure')
Data.map[12] = require('aeolus/data/settime')
Data.map[65] = require('aeolus/data/temp')
Data.map[82] = require('aeolus/data/toast')
Data.map[73] = require('aeolus/data/wind')


local function _read_by_block(data_str)
    local sep_pos = string.find(data_str, Data.BLOCK_KEY .. Data.BLOCK_KEY)
print('~~~~~~~~~~~~~~~~~~~~~~~~~~~')
    if sep_pos == nil then
        return data_str, nil
    else
        return string.sub(data_str, 1, sep_pos + 1), string.sub(data_str, sep_pos + 2, #data_str)
    end
end

local function _data_id(hex_data)
    return tonumber(string.sub(hex_data, 3, 4), 16)
end

local function _data(hex_data)
    return string.sub(hex_data, 5, #hex_data - 6)
end

local function _data_crc(hex_data)
    return tonumber(string.sub(hex_data, #hex_data - 5, #hex_data - 2), 16)
end


function Data:check(hex_data)
    local last_block_key = string.sub(hex_data, #hex_data - 1, #hex_data)
    local first_block_key = string.sub(hex_data, 1, 2)

    if first_block_key == Data.BLOCK_KEY and first_block_key == last_block_key then
        hex_data = string.gsub(hex_data, ':', '')
    else
        hex_data = nil
    end

    return hex_data
end

function Data:parse(next_data)
    next_data = self:check(next_data)

    if next_data == nil then
        return nil, 'ERROR: Invalid HEX data'
    end

    local data = {}
    local current_data = nil
    local id, crc

    while next_data do
        current_data, next_data = _read_by_block(next_data)

        id = _data_id(current_data)

        if self.map[id] == nil then
            print('ERROR: Invalid data ID')
        else
            data[self.map[id].NAME] = self.map[id]:read(_data(current_data))
            data[self.map[id].NAME].crc = _data_crc(current_data)
        end
    end

    return data, nil
end


return Data
