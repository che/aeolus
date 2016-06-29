
local data = {}


data.BLOCK_KEY = '7e'

data.map = {}
data.map[63] = require('aeolus/data/accel')
data.map[51] = require('aeolus/data/aeolusinfo')
data.map[71] = require('aeolus/data/attitude')
data.map[75] = require('aeolus/data/calibinfo')
data.map[11] = require('aeolus/data/command')
data.map[72] = require('aeolus/data/compass')
data.map[76] = require('aeolus/data/debuginfo')
data.map[66] = require('aeolus/data/gps')
data.map[62] = require('aeolus/data/gyro')
data.map[81] = require('aeolus/data/log')
data.map[64] = require('aeolus/data/magnet')
data.map[61] = require('aeolus/data/pressure')
data.map[12] = require('aeolus/data/settime')
data.map[65] = require('aeolus/data/temp')
data.map[82] = require('aeolus/data/toast')
data.map[73] = require('aeolus/data/wind')


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

    if array[1] == data.BLOCK_KEY and array[1] == array[#array] then
        table.remove(array, #array)
        table.remove(array, 1)
    else
        array = nil
    end

    return array
end

function data:parse(hex_data)
    local message_error = nil
    local data_name = nil
    local data_table = {}
    local id, crc

    local array = array(hex_data)

    if array == nil then
        return nil, nil, 'ERROR: Invalid HEX data'
    else
        id, array, crc = id_data_crc(array)

        data_name = data.map[id].NAME

        data_table.message_id = id
        data_table.crc = crc

        data.map[id]:read(array)
    end

    return data_name, data_table, message_error
end


return data
