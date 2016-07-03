
local AeolusInfo = {}


AeolusInfo.ID = 51
AeolusInfo.SIZE = 32 * 2
AeolusInfo.NAME = 'aeolusinfo'

local _FIRMWARE_VERSION = '%s.%s.%s'
local _MAC_ADDRESS = '%s:%s:%s:%s:%s:%s'

local _MODEL_NAME = {}
_MODEL_NAME[65] = 'AEOLUS'
_MODEL_NAME[83] = 'AEOLUS SENSE'


function AeolusInfo:read(hex_data)
    local data = {}

    -- AEOLUS model ID
    data.model_id = tonumber(hex_data:sub(1, 2), 16)

    -- AEOLUS model name
    data.model_name = _MODEL_NAME[data.model_id]

    -- AEOLUS firmware version
    data.firmware_version = _FIRMWARE_VERSION:format(
        tonumber(hex_data:sub(3, 4), 16),
        tonumber(hex_data:sub(5, 6), 16),
        tonumber(hex_data:sub(7, 8), 16))

    -- AEOLUS MAC address
    data.mac_address = _MAC_ADDRESS:format(
        hex_data:sub(17, 18),
        hex_data:sub(19, 20),
        hex_data:sub(21, 22),
        hex_data:sub(23, 24),
        hex_data:sub(25, 26),
        hex_data:sub(27, 28))

    hex_data = nil

    return data
end


return AeolusInfo
