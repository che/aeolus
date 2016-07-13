
local PCAPEmmiter = {}

local ENV = require('aeolus/env')

local Socket = require('socket')


PCAPEmmiter.DEFAULT_TIMEOUT = 0.01
PCAPEmmiter.DEFAULT_IP = '127.0.0.1'
PCAPEmmiter.DEFAULT_PORT = 5001
PCAPEmmiter.DEFAULT_SERVICE_PORT = 5002
PCAPEmmiter.DEFAULT_DATA_FILE = ENV.VAR_DIR .. '/aeolus.pcap.data'
PCAPEmmiter.DEFAULT_DATA_LOOP = false

PCAPEmmiter.timeout = ENV:get('AEOLUS_PCAP_EMMITER_TIMEOUT') or PCAPEmmiter.DEFAULT_TIMEOUT
PCAPEmmiter.ip = ENV:get('AEOLUS_PCAP_EMMITER_IP') or PCAPEmmiter.DEFAULT_IP
PCAPEmmiter.port = ENV:get('AEOLUS_PCAP_EMMITER_PORT') or PCAPEmmiter.DEFAULT_PORT
PCAPEmmiter.service_port = ENV:get('AEOLUS_PCAP_EMMITER_SERVICE_PORT') or PCAPEmmiter.DEFAULT_SERVICE_PORT
PCAPEmmiter.data_file = ENV:get('AEOLUS_PCAP_EMMITER_DATA_FILE') or PCAPEmmiter.DEFAULT_DATA_FILE
PCAPEmmiter.data_loop = ENV:get('AEOLUS_PCAP_EMMITER_DATA_LOOP') or PCAPEmmiter.DEFAULT_DATA_LOOP


local _MAC_ADDRESS_SEP = ':'
local _SPACE_SEP = '%S+'
local _SPACE_STR = ' '
local _EMPTY_STR = ''
local _TAB_STR = '\t'

local _KEY_READ_LINE = '*line'
local _KEY_BROADCAST = 'broadcast'

local _FILE_R_MODE = 'r'

local _udp_socket = nil
local _udp_socket_send = nil
local _data_file = nil


local function _close()
    if _udp_socket then
        _udp_socket:close()
    end

    _udp_socket = nil
end

local function _init()
    _close()

    _udp_socket = Socket.udp()

    _udp_socket:settimeout(0)

    if _udp_socket:setoption(_KEY_BROADCAST, true) then

    else
        print('ERROR: Already exixsts!')
        _close()

        os.exit()
    end
end

local function _service_close()
    if _udp_socket_service then
        _udp_socket_service:close()
    end

    _udp_socket_service = nil
end

local function _service_init()
    _service_close()

    _udp_socket_service = Socket.udp()

    _udp_socket_service:settimeout(0)

    if _udp_socket_service:setsockname(PCAPEmmiter.ip, PCAPEmmiter.service_port) then

    else
        print('ERROR: Already exixsts!')
        _service_close()

        os.exit()
    end
end

local function _data_file_close()
    if _data_file then
        _data_file:close()
    end

    _data_file = nil
end

local function _data_file_init()
    _data_file_close()

    _data_file = io.open(PCAPEmmiter.data_file, _FILE_R_MODE)
end

local function _hex_data_to_binary(hex_data)
    return (hex_data:gsub('..',
        function (c)
            return string.char(tonumber(c, 16))
        end)
    )
end

local function _data_file_parse(pcap_data)
    if pcap_data then
        local value = {}

        for i in string.gmatch(pcap_data:gsub(_TAB_STR, _SPACE_STR), _SPACE_SEP) do
            value[#value + 1] = i
        end

        if #value == 10 then
            value = _hex_data_to_binary(value[10]:gsub( _MAC_ADDRESS_SEP, _EMPTY_STR))
        else
            value = nil
        end

        return value
    else
        return nil
    end
end

local function _data_file_read()
    if _data_file == nil then
        return nil
    end

    local _data = _data_file:read(_KEY_READ_LINE)
    local _parse_data = nil

    if _data == nil then
        _data_file_close()

        if PCAPEmmiter.data_loop then
            _data_file_init()

            _data = _data_file:read(_KEY_READ_LINE)
        end
    end

    _parse_data = _data_file_parse(_data)

    while _data and _parse_data == nil do
        _parse_data = _data_file_read()
    end

    return _parse_data
end

local function _sendto(i)
    local current_time = os.clock()
    local data = _data_file_read()
    local error_message = nil

    if data == nil then
        return nil
    end

    data, error_message = _udp_socket:sendto(data, PCAPEmmiter.ip, PCAPEmmiter.port)

    if data and error_message == nil then
        print(('Message send: %d !!!'):format(i))
    else
        print('ERROR: ' .. error_message)
    end

    return os.clock() - current_time
end

local function _receive()
    local current_time = os.clock()
    local data, error_message = _udp_socket_service:receive()

    if data and error_message == nil then
        print(('Message receive: %s'):format(data))
    else
        if error_message == 'timeout' then
--            print('WARNING: Unknown network error by timeout')
        elseif error_message == 'closed' then
            print('ERROR: Network connection was closed')
        else
            print('ERROR: ' .. error_message)
        end
    end

    return os.clock() - current_time
end


function PCAPEmmiter:init()
    _init()
    _service_init()
    _data_file_init()
end

function PCAPEmmiter:run()
    local i = 0

    while true do
        i = i + 1

        local timeout = _sendto(i)

        if timeout == nil then
            print('Finished!')
            break
        else
            timeout = self.timeout - (timeout + _receive())
        end

        if timeout > 0 then
            Socket.sleep(timeout)
        end
    end
end

function PCAPEmmiter:close()
    _data_file_close()
    _service_close()
    _close()
end


return PCAPEmmiter
