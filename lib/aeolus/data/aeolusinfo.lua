
-- Information about device

local AeolusInfo = {}


AeolusInfo.ID = 51
AeolusInfo.SIZE = 32
AeolusInfo.NAME = 'aeolusinfo'

local _FIRMWARE_VERSION = '%d.%d.%d'
local _MAC_ADDRESS = '%x:%x:%x:%x:%x:%x'

local _MODEL_NAME = {}
_MODEL_NAME[65] = 'AEOLUS'
_MODEL_NAME[83] = 'AEOLUS SENSE'

local _MODEL = {}
_MODEL[0] = 'N/A'
_MODEL[1] = '3a'
_MODEL[2] = '3b'


function AeolusInfo:read(byte_data)
    local data = {}

    -- Model ID
    data.model_id = byte_data:byte(1)

    -- Model name
    data.model_name = _MODEL_NAME[data.model_id]

    -- Firmware version
    data.firmware_version = _FIRMWARE_VERSION:format(
        byte_data:byte(2),
        byte_data:byte(3),
        byte_data:byte(4))

    -- Model
    data.model = _MODEL[byte_data:byte(5)]

    -- MAC address
    data.mac_address = _MAC_ADDRESS:format(
        byte_data:byte(9),
        byte_data:byte(10),
        byte_data:byte(11),
        byte_data:byte(12),
        byte_data:byte(13),
        byte_data:byte(14))

    -- Number of reboots mod
    data.number_of_reboots_mod = byte_data:byte(15)

    -- Number of reboots div
    data.number_of_reboots_div = byte_data:byte(16)

    byte_data = nil

    return data
end


return AeolusInfo
