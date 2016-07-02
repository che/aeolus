
local Data = {}


Data.BLOCK_KEY = '7e'
Data.XOR_KEY = '7d'

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


local function _data_id(hex_data)
    return tonumber(hex_data:sub(3, 4), 16)
end

local function _data(hex_data)
    return hex_data:sub(5, #hex_data - 6)
end

local function _data_crc(hex_data)
    return tonumber(hex_data:sub(#hex_data - 5, #hex_data - 2), 16)
end

local function _read_by_block(data_str)
    local id = _data_id(data_str)

    if Data.map[id] == nil then
        return id, nil, 'ERROR: Invalid data ID'
    end

    if data_str:sub(Data.map[id].SIZE + 9, Data.map[id].SIZE + 10) == Data.BLOCK_KEY then
        if #data_str > Data.map[id].SIZE + 12 then
            return id, data_str:sub(1, Data.map[id].SIZE + 10), data_str:sub(Data.map[id].SIZE + 11, #data_str)
        else
            return id, data_str, nil
        end
    else
        return id, nil, 'ERROR: Invalid data block size'
    end
end


function Data:check(hex_data)
    local last_block_key = hex_data:sub(#hex_data - 1, #hex_data)
    local first_block_key = hex_data:sub(1, 2)

    if first_block_key == Data.BLOCK_KEY and first_block_key == last_block_key then
        hex_data = hex_data:gsub(Data.XOR_KEY, ''):gsub(':', '')
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
        id, current_data, next_data = _read_by_block(next_data)

        if current_data == nil then
            return current_data, next_data
        end
        crc = _data_crc(current_data)

        current_data = _data(current_data)

        data[self.map[id].NAME] = self.map[id]:read(current_data)
    end

    return data, nil
end


return Data
