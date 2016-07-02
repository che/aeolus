
local CalibInfo = {}


CalibInfo.ID = 75
CalibInfo.SIZE = 32 * 2
CalibInfo.NAME = 'calibinfo'


function CalibInfo:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    --TODO: new datasheet
    -- Message
--    if hex_data == nil then
        data.message = nil
--    else
        --TODO: new datasheet
--        data.message = tonumber(hex_data:sub(1, self.SIZE), 16)
--    end
print(data.message)

    hex_data = nil

    return data
end


return CalibInfo
