
local Receiver = {}


local AeolusData = require('aeolus/data')
local AeolusDB = require('aeolus/db')
local ENV = require('aeolus/env')

local Socket = require('socket')


Receiver.DEFAULT_TIMEOUT = 0.01
Receiver.DEFAULT_TIMEOUT_MULTIPLIER = 2
Receiver.DEFAULT_IP = '127.0.0.1'
Receiver.DEFAULT_PORT = 5001
Receiver.DEFAULT_SERVICE_PORT = 5002

Receiver.timeout = ENV:get('AEOLUS_RECEIVER_TIMEOUT') or Receiver.DEFAULT_TIMEOUT
Receiver.timeout_multiplier = ENV:get('AEOLUS_RECEIVER_TIMEOUT_MULTIPLIER') or Receiver.DEFAULT_TIMEOUT_MULTIPLIER
Receiver.ip = ENV:get('AEOLUS_RECEIVER_IP') or Receiver.DEFAULT_IP
Receiver.port = ENV:get('AEOLUS_RECEIVER_PORT') or Receiver.DEFAULT_PORT
Receiver.service_port = ENV:get('AEOLUS_RECEIVER_SERVICE_PORT') or Receiver.DEFAULT_SERVICE_PORT


local _udp_socket = nil

local _SOCKET_STATUS = {}
_SOCKET_STATUS.timeout = 'timeout'
_SOCKET_STATUS.closed = 'closed'


local function _data_parse(byte_data)
    local data, error_message = AeolusData:parse(byte_data)

    for data_type, data_table in pairs(data) do
        print(data_type)

        if not AeolusDB.Table.Data:table_exists('', data_type) then
            AeolusDB.Table.Data:table_create('', data_type)
        end
--        if Aeolus.DB.Table.Data:table_exists(values[2], data_type) then
--            Aeolus.DB.Table.Data:table_delete(values[2], data_type)
--        end

----        Aeolus.DB.Table.Data:insert(values[2], data_type, data_table)
        AeolusDB.Table.Data:insert('', data_type, data_table)
--        Aeolus.DB.Table.Data:delete(values[2], data_type, data_table)
    end
end

local function _receive()
    local current_time = os.clock()
    local data, error_message = _udp_socket:receive()

    if data and error_message == nil then
        _data_parse(data)
    else
        if error_message == _SOCKET_STATUS.timeout then
--            print('WARNING: Unknown network error by timeout')
        elseif error_message == _SOCKET_STATUS.closed then
            print('ERROR: Network connection was closed')
        else
            print('ERROR: ' .. error_message)
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
--        print('Message send !')
--    else
--        print('ERROR: ' .. error_message)
--    end

    return os.clock() - current_time
end

local function _db_init()
--    Aeolus.DB:create()
    AeolusDB:connect()
    AeolusDB:settings()

    if not AeolusDB.Table.Emmiter:table_exists() then
        AeolusDB.Table.Emmiter:table_create()
    end
end


function Receiver:init()
    if _udp_socket then
        self:close()
    end

    _udp_socket = Socket.udp()

    _udp_socket:settimeout(0)

    if _udp_socket:setsockname(self.ip, self.port) then

    else
        print('ERROR: Receiver already was run!')
        self:close()

        os.exit()
    end

    _db_init()
end

function Receiver:run()
    while true do
        local timeout = self.timeout - (_receive() + _sendto()) * self.timeout_multiplier

        if timeout > 0 then
            Socket.sleep(timeout)
        end
    end
end

function Receiver:close()
    if _udp_socket then
        _udp_socket:close()
    end

    _udp_socket = nil

    AeolusDB:close()
end


return Receiver
