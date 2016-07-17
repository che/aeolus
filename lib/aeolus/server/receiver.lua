
local Receiver = {}


require('aeolus/env')
require('aeolus/log')

local Data = require('aeolus/data')
local DB = require('aeolus/db')

local Socket = require('socket')


Receiver.DEFAULT_TIMEOUT = 0.01
Receiver.DEFAULT_TIMEOUT_MULTIPLIER = 1
Receiver.DEFAULT_IP = '127.0.0.1'
Receiver.DEFAULT_PORT = 5001
Receiver.DEFAULT_SERVICE_PORT = 5002

Receiver.timeout = Env:get('AEOLUS_RECEIVER_TIMEOUT', Env.number) or Receiver.DEFAULT_TIMEOUT
Receiver.timeout_multiplier = Env:get('AEOLUS_RECEIVER_TIMEOUT_MULTIPLIER', Env.number) or Receiver.DEFAULT_TIMEOUT_MULTIPLIER
Receiver.ip = Env:get('AEOLUS_RECEIVER_IP') or Receiver.DEFAULT_IP
Receiver.port = Env:get('AEOLUS_RECEIVER_PORT', Env.number) or Receiver.DEFAULT_PORT
Receiver.service_port = Env:get('AEOLUS_RECEIVER_SERVICE_PORT', Env.number) or Receiver.DEFAULT_SERVICE_PORT

local _udp_socket = nil

local _SOCKET_STATUS = {}
_SOCKET_STATUS.timeout = 'timeout'
_SOCKET_STATUS.closed = 'closed'


local function _data_parse_emmiter(error_or_mac)
    if not DB.Table.Emmiter:exists(error_or_mac) then
        Log:debug(('Receiver: emmiter %s does not exist'):format(error_or_mac))
        local data_table = {}

        data_table.mac_address = error_or_mac
        data_table.ip = Receiver.ip
        data_table.port = Receiver.port

        if DB.Table.Emmiter:insert(data_table) then
            Log:debug(('Receiver: emmiter %s was inserted'):format(error_or_mac))
        else
            Log:error(('Receiver: emmiter %s was not inserted'):format(error_or_mac))
        end
        data_table = nil
    else
        Log:debug(('Receiver: emmiter %s exists'):format(error_or_mac))
    end
end

local function _data_parse_table(data, error_or_mac)
    for data_type, data_table in pairs(data) do
        local table_name = DB.Table.Data:table_name(error_or_mac, data_type)
        Log:debug('Receiver: data of ' .. data_type)

        if not DB.Table.Data:table_exists(error_or_mac, data_type) then
            Log:debug(('Receiver: table %s does not exist'):format(table_name))

            if DB.Table.Data:table_create(error_or_mac, data_type) then
                Log:debug(('Receiver: table %s was created'):format(table_name))
            else
                Log:error(('Receiver: table %s was not created'):format(table_name))
            end
        end

        if DB.Table.Data:insert(error_or_mac, data_type, data_table) then
            Log:debug(('Receiver: data was inserted in %s'):format(table_name))
        else
            Log:error(('Receiver: data was not inserted in %s'):format(table_name))
        end
    end
end

local function _data_parse(byte_data)
    local data, error_or_mac = Data:parse(byte_data)

    if data and error_or_mac then
        Log:debug('Receiver: device MAC address was defined')

        _data_parse_emmiter(error_or_mac)

        _data_parse_table(data, error_or_mac)
    elseif error_or_mac and data == nil then
        Log:error('Receiver: ' .. error_or_mac)
    end
end

local function _receive()
    local current_time = os.clock()
    local data, error_message = _udp_socket:receive()

    Log:debug('Receiver: data was received')
    if data and error_message == nil then
        _data_parse(data)
    else
        if error_message == _SOCKET_STATUS.timeout then
            Log:warn('Receiver: unknown network error as timeout')
        elseif error_message == _SOCKET_STATUS.closed then
            Log:error('Receiver: network connection was closed')
        else
            Log:error('Receiver: ' .. error_message)
        end
    end

    return os.clock() - current_time
end

local function _sendto()
    local current_time = os.clock()
--    local data, error_message = _udp_socket:sendto('a Service',
--                                                    Receiver.ip,
--                                                    Receiver.service_port)

--    if data and error_message == nil then
--        Log:debug('Receiver: message was sent')
--    else
--        Log:error('Receiver: ' .. error_message)
--    end

    return os.clock() - current_time
end

local function _db_init()
    if DB:connect() then
        Log:debug('Receiver: DB connection was created')
    else
        Log:fatal('Receiver: DB connection does not create')
        os.exit(1)
    end
    if DB:settings() then
        Log:debug('Receiver: DB settings was created')
    else
        Log:error('Receiver: DB settings does not create')
    end

    if not DB.Table.Emmiter:table_exists() then
        Log:debug('Receiver: table Emmiter does not exist')
        if DB.Table.Emmiter:table_create() then
            Log:debug('Receiver: table Emmiter was created')
        else
            Log:error('Receiver: table Emmiter was not created')
        end
    end
end


function Receiver:init()
    if _udp_socket then
        self:close()
    end

    _udp_socket = Socket.udp()
    _udp_socket:settimeout(0)

    if _udp_socket:setsockname(self.ip, self.port) then
        Log:debug(('Receiver: UDP socket was setuped for ip=%s, port=%s'):format(self.ip, self.port))
    else
        Log:fatal('Receiver already was runned!')
        self:close()
        os.exit(1)
    end

    _db_init()
end

function Receiver:run()
    Log:debug('Receiver was runned')

    while true do
        local timeout = self.timeout - (_receive() + _sendto()) * self.timeout_multiplier

        if timeout > 0 then
            Log:debug(('Receiver: timeout %s'):format(timeout))
            Socket.sleep(timeout)
        else
            Log:warn('Receiver: timeout less 0')
        end
    end
end

function Receiver:close()
    if _udp_socket then
        _udp_socket:close()
        Log:debug('Receiver: UDP socket was closed')
    end

    _udp_socket = nil

    DB:close()
    Log:debug('Receiver: DB connection was closed')
end


return Receiver
