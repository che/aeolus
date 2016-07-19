
-- Debug information (internal use)

local DebugInfo = {}


DebugInfo.ID = 76
DebugInfo.SIZE = 200
DebugInfo.NAME = 'debuginfo'


function DebugInfo:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    byte_data = nil

    return data
end


return DebugInfo
