
local CalibInfo = {}


CalibInfo.ID = 75
CalibInfo.SIZE = 32
CalibInfo.NAME = 'calibinfo'


function CalibInfo:read(byte_data)
    local data = {}

    --TODO: new datasheet
    -- Message
    if byte_data == nil then
        data.message = nil
    else
        --TODO: new datasheet
        data.message = byte_data:sub(1, self.SIZE)
    end

    byte_data = nil

    return data
end


return CalibInfo
