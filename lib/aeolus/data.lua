
local Data = {}


Data.BLOCK_BYTE_KEY = tonumber('0x7e', 16)
Data.XOR_BYTE_KEY = tonumber('0x7d', 16)

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

        data[Data.map[id].NAME] = read_data
    elseif not (_mac_address_native == read_data.mac_address) then
        print('ERROR: Wrong MAC Address for current data')
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

    if Data.map[id] == nil then
        return id, nil, 'ERROR: Invalid data ID'
    end

    if byte_data:byte(Data.map[id].SIZE + 5) == Data.BLOCK_BYTE_KEY then
        if byte_data:byte(Data.map[id].SIZE + 6) == nil then
            return id, byte_data, nil
        else
            return id, byte_data:sub(1, Data.map[id].SIZE + 5), byte_data:sub(Data.map[id].SIZE + 6, #byte_data)
        end
    else
        return id, nil, 'ERROR: Invalid data block size'
    end
end


if string.pack == nil and string.unpack == nil then
    require('pack')


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
        _data = nil
    else
        byte_data = nil
    end

    return byte_data
end

function Data:parse(next_data)
    next_data = self:check(next_data)

    if next_data == nil then
        return nil, 'ERROR: Invalid byte data'
    end

    local data = {}
    local current_data = nil
    local id, crc

    while next_data do
        id, current_data, next_data = _read_by_block(next_data)

        if current_data == nil then

        else
            crc = _data_crc(current_data, self.map[id].SIZE)

            if crc == 0 then
                current_data = _data(current_data, self.map[id].SIZE)

                if id == 51 then  -- AeolusInfo
                    _define_mac_address(id, data, self.map[id]:read(current_data, Data))
                elseif _mac_address then
                    data[self.map[id].NAME] = self.map[id]:read(current_data, Data)
                end
            else
                print(('WARNING: Invalid CRC %x'):format(crc))
            end
        end
    end

    return data, _mac_address
end


return Data
