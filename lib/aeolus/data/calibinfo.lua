
-- Calibration status (internal use)

local CalibInfo = {}


CalibInfo.ID = 75
CalibInfo.SIZE = 36
CalibInfo.NAME = 'calibinfo'

local _MAC_ADDRESS = '%x:%x:%x:%x:%x:%x'


function CalibInfo:read(byte_data)
    local data = {}

    -- Calibration enable
    data.calibration_enable_1 = byte_data:byte(1)

    -- Calibration enable
    data.calibration_enable_2 = byte_data:byte(2)

    -- Calibration working
    data.calibration_working = byte_data:byte(3)

    -- Has value
    data.has_value = byte_data:byte(4)

    -- Temperature calibrated N
    data.temperature_calibrated_n = byte_data:byte(5)

    -- MAC address
    data.mac_address = _MAC_ADDRESS:format(
        byte_data:byte(9),
        byte_data:byte(10),
        byte_data:byte(11),
        byte_data:byte(12),
        byte_data:byte(13),
        byte_data:byte(14))

    -- Info N runs per
    data.info_n_runs_per = byte_data:byte(15)

    -- Info N runs
    data.info_n_runs = byte_data:byte(16)

    -- Temperature
    data.temperature = self:float(byte_data:sub(17, 20))

    -- Calibration summary
    data.calibration_sum = self:float(byte_data:sub(21, 24))

    -- Temperature OAT
    data.temperature_oat = self:float(byte_data:sub(25, 28))

    -- Temperature calibrated min
    data.temperature_calibrated_min = self:float(byte_data:sub(29, 32))

    -- Temperature calibrated max
    data.temperature_calibrated_max = self:float(byte_data:sub(33, 36))

    byte_data = nil

    return data
end


return CalibInfo
