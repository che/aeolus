
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


local function id_data_crc(array)
    local id = nil
    local crc = nil

    table.remove(array, #array)
    table.remove(array, 1)

    id = tonumber(array[1], 16)
    table.remove(array, 1)

    crc = tonumber(string.format("%s%s", array[#array - 1], array[#array]), 16)
    table.remove(array, #array)
    table.remove(array, #array)

    return id, array, crc
end

local function array(hex_data)
    local array = {}

    for value in string.gmatch(hex_data, '([^:]+)') do
        array[#array + 1] = value
    end

    if array[1] == Data.BLOCK_KEY and array[1] == array[#array] then
        hex_data = nil
    else
        array = nil
    end

    return array
end

local function array_read_by_block(array)
    if not array[1] == Data.BLOCK_KEY and not array[#array] == Data.BLOCK_KEY then
        return nil, nil
    end

    local data_block = {}

    for i = 1, #array do
        data_block[#data_block + 1] = table.remove(array, 1)

        if #data_block > 1 and data_block[#data_block] == Data.BLOCK_KEY then
            if #array == 0 then
                array = nil
            end

            return data_block, array
        end
    end
end


function Data:parse(hex_data)
    local array = array(hex_data)
    local data = {}
    local next_array = {}
    local id, crc

    if array == nil then
        return nil, 'ERROR: Invalid HEX data'
    else
        while next_array do
            current_array, next_array = array_read_by_block(array)

            id, current_array, crc = id_data_crc(current_array)
print(id)
            data[self.map[id].NAME] = self.map[id]:read(current_array)
        end
    end

    return data, nil
end


return Data
