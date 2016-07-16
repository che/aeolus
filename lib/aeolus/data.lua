
local Data = {}


require('aeolus/log')


Data.BLOCK_BYTE_KEY = tonumber('0x7e', 16)
Data.XOR_BYTE_KEY = tonumber('0x7d', 16)

local _map = {}
_map[63] = require('aeolus/data/accel')
_map[51] = require('aeolus/data/aeolusinfo')
_map[71] = require('aeolus/data/attitude')
_map[75] = require('aeolus/data/calibinfo')
_map[11] = require('aeolus/data/command')
_map[72] = require('aeolus/data/compass')
_map[76] = require('aeolus/data/debuginfo')
_map[66] = require('aeolus/data/gps')
_map[62] = require('aeolus/data/gyro')
_map[12] = require('aeolus/data/info')
_map[81] = require('aeolus/data/log')
_map[64] = require('aeolus/data/magnet')
_map[61] = require('aeolus/data/pressure')
_map[74] = require('aeolus/data/te')
_map[65] = require('aeolus/data/temp')
_map[82] = require('aeolus/data/toast')
_map[73] = require('aeolus/data/wind')
_map[91] = require('aeolus/data/wp')
-- Inheritance
for _, class in pairs(_map) do
    setmetatable(class, {__index = Data})
end

local _STR_DOUBLE = 'd'
local _STR_FLOAT = 'f'

local _MAC_ADDRESS_SEP = ':'
local _EMPTY_STR = ''

local _mac_address = nil
local _mac_address_native = nil


local function _define_mac_address(id, data, read_data)
    if _mac_address == nil then
        _mac_address_native = read_data.mac_address
        _mac_address = _mac_address_native:gsub(_MAC_ADDRESS_SEP, _EMPTY_STR)
        Log:debug('Data: MAC Address was defined')

        data[_map[id].NAME] = read_data
        Log:debug('Data: data AeolusInfo was read')
    elseif not (_mac_address_native == read_data.mac_address) then
        Log:error('Data: wrong MAC Address for current data')
    end
end

local function _data_id(byte_data)
    return byte_data:byte(2)
end

local function _data_crc(byte_data, data_size)
    local byte_1, byte_2 = byte_data:byte(data_size + 3, data_size + 4)

    if byte_1 == byte_2 and byte_1 == 0 then
        return 0
    else
        return byte_data:sub(data_size + 3, data_size + 4)
    end
end

local function _data(byte_data, data_size)
    return byte_data:sub(3, data_size + 2)
end

local function _read_by_block(byte_data)
    local id = _data_id(byte_data)

    if _map[id] == nil then
        Log:error(('Data: invalid data ID=%d'):format(id))
        return id, nil, 'Invalid data ID'
    else
        Log:debug(('Data: valid data ID=%d was defined'):format(id))
    end

    if byte_data:byte(_map[id].SIZE + 5) == Data.BLOCK_BYTE_KEY then
        if byte_data:byte(_map[id].SIZE + 6) == nil then
            Log:debug('Data: last data was read in block')
            return id, byte_data, nil
        else
            Log:debug('Data: next data was read in block')
            return id, byte_data:sub(1, _map[id].SIZE + 5), byte_data:sub(_map[id].SIZE + 6, #byte_data)
        end
    else
        Log:error('Data: invalid block size')
        return id, nil, 'Invalid data block size'
    end
end


if string.pack == nil and string.unpack == nil then
    require('pack')
    Log:debug('Data: library lpack was loaded')


    function Data:timestamp(bytes)
        local d = nil
        local i = nil

        if bytes then
            i, d = bytes:unpack(_STR_DOUBLE)
        end

        return d
    end

    function Data:float(bytes)
        local f = nil
        local i = nil

        if bytes then
            i, f = bytes:unpack(_STR_FLOAT)
        end

        return f
    end
else
    function Data:timestamp(bytes)
        if bytes == nil then
            return nil
        else
            return bytes:unpack(_STR_DOUBLE)
        end
    end

    function Data:float(bytes)
        if bytes == nil then
            return nil
        else
            return bytes:unpack(_STR_FLOAT)
        end
    end
end

function Data:check(byte_data)
    local last_block_key = byte_data:byte(#byte_data)
    local first_block_key = byte_data:byte(1)

    if first_block_key == self.BLOCK_BYTE_KEY and first_block_key == last_block_key then
        local _data = {}

        for i = 0, #byte_data do
            if not (byte_data:byte(i, i) == self.XOR_BYTE_KEY) then
                _data[#_data + 1] = string.char(byte_data:byte(i))
            end
        end

        byte_data = table.concat(_data)
        Log:debug('Data: valid data was got')
        _data = nil
    else
        Log:warn('Data: invalid data was got')
        byte_data = nil
    end

    return byte_data
end

function Data:parse(next_data)
    next_data = self:check(next_data)

    if next_data == nil then
        return nil, 'Invalid byte data'
    end

    local data = {}
    local current_data = nil
    local id, crc

    while next_data do
        id, current_data, next_data = _read_by_block(next_data)
        if current_data == nil then
            Log:error(next_data)
        else
            crc = _data_crc(current_data, _map[id].SIZE)

            if crc == 0 then
                Log:debug(('Data: valid CRC for ID=%d'):format(id))
                current_data = _data(current_data, _map[id].SIZE)

                if id == 51 then  -- AeolusInfo
                    _define_mac_address(id, data, _map[id]:read(current_data))
                elseif _mac_address then
                    data[_map[id].NAME] = _map[id]:read(current_data)
                    Log:debug(('Data: valid data was read for ID=%d'):format(id))
                end
            else
                Log:warn(('Data: invalid CRC %s for ID=%d'):format(crc, id))
            end
        end
    end

    return data, _mac_address
end


return Data
