
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
        table.remove(array, #array)
        table.remove(array, 1)
    else
        array = nil
    end

    return array
end

function Data:parse(hex_data)
    local message_error = nil
    local data_name = nil
    local data_table = {}
    local id, crc

    local array = array(hex_data)

    if array == nil then
        return nil, nil, 'ERROR: Invalid HEX data'
    else
        id, array, crc = id_data_crc(array)

        data_name = self.map[id].NAME

        data_table.message_id = id
        data_table.crc = crc

        self.map[id]:read(array)
    end

    return data_name, data_table, message_error
end


return Data
