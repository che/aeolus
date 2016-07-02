
local AeolusInfo = {}


AeolusInfo.ID = 51
AeolusInfo.SIZE = 32 * 2
AeolusInfo.NAME = 'aeolusinfo'

local FIRMWARE_VERSION = '%s.%s.%s'
local MAC_ADDRESS = '%s:%s:%s:%s:%s:%s'

local MODEL_NAME = {}
MODEL_NAME[65] = 'AEOLUS'
MODEL_NAME[83] = 'AEOLUS SENSE'


function AeolusInfo:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    -- AEOLUS model ID
    data.model_id = tonumber(hex_data:sub(1, 2), 16)
print(data.model_id)

    -- AEOLUS model name
    data.model_name = MODEL_NAME[data.model_id]
print(data.model_name)

    -- AEOLUS firmware version
    data.firmware_version = FIRMWARE_VERSION:format(
        tonumber(hex_data:sub(3, 4), 16),
        tonumber(hex_data:sub(5, 6), 16),
        tonumber(hex_data:sub(7, 8), 16))
print(data.firmware_version)

    -- AEOLUS MAC address
    data.mac_address = MAC_ADDRESS:format(
        hex_data:sub(17, 18),
        hex_data:sub(19, 20),
        hex_data:sub(21, 22),
        hex_data:sub(23, 24),
        hex_data:sub(25, 26),
        hex_data:sub(27, 28))
print(data.mac_address)

    hex_data = nil

    return data
end


return AeolusInfo
