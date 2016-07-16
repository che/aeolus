
local PCAPEmitter = {}


require('aeolus/env')
require('aeolus/log')

local Socket = require('socket')


PCAPEmitter.DEFAULT_TIMEOUT = 0.01
PCAPEmitter.DEFAULT_IP = '127.0.0.1'
PCAPEmitter.DEFAULT_PORT = 5001
PCAPEmitter.DEFAULT_SERVICE_PORT = 5002
PCAPEmitter.DEFAULT_DATA_FILE = 'aeolus.pcap.data'
PCAPEmitter.DEFAULT_DATA_DIR = Env.DIR
PCAPEmitter.DEFAULT_DATA_LOOP = false

PCAPEmitter.timeout = Env:get('AEOLUS_PCAP_EMITTER_TIMEOUT', Env.number) or PCAPEmitter.DEFAULT_TIMEOUT
PCAPEmitter.ip = Env:get('AEOLUS_PCAP_EMITTER_IP') or PCAPEmitter.DEFAULT_IP
PCAPEmitter.port = Env:get('AEOLUS_PCAP_EMITTER_PORT', Env.number) or PCAPEmitter.DEFAULT_PORT
PCAPEmitter.service_port = Env:get('AEOLUS_PCAP_EMITTER_SERVICE_PORT', Env.number) or PCAPEmitter.DEFAULT_SERVICE_PORT
PCAPEmitter.data_file = Env:get('AEOLUS_PCAP_EMITTER_DATA_FILE') or PCAPEmitter.DEFAULT_DATA_FILE
PCAPEmitter.data_dir = Env:get('AEOLUS_PCAP_EMITTER_DATA_DIR') or PCAPEmitter.DEFAULT_DATA_DIR
PCAPEmitter.data_loop = Env:get('AEOLUS_PCAP_EMITTER_DATA_LOOP', Env.boolean) or PCAPEmitter.DEFAULT_DATA_LOOP


local _HEX_FORMAT_STR = '%02x'
local _MAC_ADDRESS_SEP = ':'
local _SPACE_SEP = '%S+'
local _2DOTS_STR = '..'
local _SPACE_STR = ' '
local _EMPTY_STR = ''
local _TAB_STR = '\t'
local _DOT_STR = '.'

local _KEY_READ_LINE = '*line'
local _KEY_BROADCAST = 'broadcast'

local _FILE_R_MODE = 'r'

local _SOCKET_STATUS = {}
_SOCKET_STATUS.timeout = 'timeout'
_SOCKET_STATUS.closed = 'closed'

local _udp_socket = nil
local _udp_socket_send = nil
local _data_file = nil


local function _close()
    if _udp_socket then
        _udp_socket:close()
        Log:debug('PCAP Emitter: UDP socket was closed')
    end

    _udp_socket = nil
end

local function _init()
    _close()

    _udp_socket = Socket.udp()

    _udp_socket:settimeout(0)

    if _udp_socket:setoption(_KEY_BROADCAST, true) then
        Log:debug('PCAP Emitter: set option BROADCAST')
    else
        Log:fatal('PCAP Emitter already was runned!')
        _close()

        os.exit(1)
    end
end

local function _service_close()
    if _udp_socket_service then
        _udp_socket_service:close()
        Log:debug('PCAP Emitter: UDP socket was closed for service')
    end

    _udp_socket_service = nil
end

local function _service_init()
    _service_close()

    _udp_socket_service = Socket.udp()

    _udp_socket_service:settimeout(0)

    if _udp_socket_service:setsockname(PCAPEmitter.ip, PCAPEmitter.service_port) then
        Log:debug(('PCAP Emitter: UDP socket was setuped for service ip=%s, port=%s'):format(PCAPEmitter.ip, PCAPEmitter.service_port))
    else
        Log:fatal('PCAP Emitter already was runned for service!')
        _service_close()

        os.exit(1)
    end
end

local function _data_file_close()
    if _data_file then
        _data_file:close()
        Log:debug('PCAP Emitter: data file handler was closed')
    end

    _data_file = nil
end

local function _data_file_init()
    _data_file_close()

    _data_file = io.open(PCAPEmitter.data_dir .. PCAPEmitter.data_file, _FILE_R_MODE)
    Log:debug(('PCAP Emitter: data file handler was created for %s%s'):format(PCAPEmitter.data_dir, PCAPEmitter.data_file))
end

local function _hex_data_to_binary(hex_data)
    return (hex_data:gsub(_2DOTS_STR,
        function (c)
            return string.char(tonumber(c, 16))
        end)
    )
end

local function _binary_data_to_hex(byte_data)
    return (byte_data:gsub(_DOT_STR, function (c)
            return string.format(_HEX_FORMAT_STR, string.byte(c))
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
            value = _hex_data_to_binary(value[10]:gsub(_MAC_ADDRESS_SEP, _EMPTY_STR))
            Log:debug('PCAP Emitter: HEX data was read')
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

        if PCAPEmitter.data_loop then
            Log:debug('PCAP Emitter: data file was opened (loop)')
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

local function _sendto()
    local current_time = os.clock()
    local byte_data = _data_file_read()
    local error_message = nil

    if byte_data == nil then
        return nil
    end

    local data, error_message = _udp_socket:sendto(byte_data, PCAPEmitter.ip, PCAPEmitter.port)
    Log:debug(('PCAP Emitter: data was sent on ip=%s, port=%s'):format(PCAPEmitter.ip, PCAPEmitter.port))

    if data and error_message == nil then
        Log:debug(('PCAP Emitter: data was sent: %s'):format(_binary_data_to_hex(byte_data)))
    else
        Log:error('PCAP Emitter: ' .. error_message)
    end
    byte_data = nil

    return os.clock() - current_time
end

local function _receive()
    local current_time = os.clock()
    local data, error_message = _udp_socket_service:receive()

    if data and error_message == nil then
        Log:debug(('PCAP Emitter: data was received: %s'):format(data))
    else
        if error_message == _SOCKET_STATUS.timeout then
            Log:warn('PCAP Emitter: unknown network error as timeout')
        elseif error_message == _SOCKET_STATUS.closed then
            Log:error('PCAP Emitter: network connection was closed')
        else
            Log:error('PCAP Emitter: ' .. error_message)
        end
    end

    return os.clock() - current_time
end


function PCAPEmitter:init()
    _init()
    _service_init()
    _data_file_init()
end

function PCAPEmitter:run()
    while true do
        local timeout = _sendto()

        if timeout == nil then
            Log:debug('PCAP Emitter: finished!')
            break
        else
            timeout = self.timeout - (timeout + _receive())
        end

        if timeout > 0 then
            Log:debug(('PCAP Emitter: timeout %s'):format(timeout))
            Socket.sleep(timeout)
        else
            Log:warn('PCAP Emitter: timeout less 0')
        end
    end
end

function PCAPEmitter:close()
    _data_file_close()
    _service_close()
    _close()
end


return PCAPEmitter
