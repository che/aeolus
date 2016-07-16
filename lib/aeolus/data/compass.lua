
-- Compass information

local Compass = {}


Compass.ID = 72
Compass.SIZE = 80
Compass.NAME = 'compass'

local _CALIBRATION = {}
_CALIBRATION[4] = 'Calibrating'
_CALIBRATION[3] = 'Calibration'
_CALIBRATION[2] = 'Just finished'
_CALIBRATION[1] = 'No calibration'
_CALIBRATION[-1] = 'Too few data'
_CALIBRATION[-2] = 'Field weak'
_CALIBRATION[-3] = 'Field distored'
_CALIBRATION[-4] = 'Error very high'


function Compass:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Calibration_status
    data.calibration_status = byte_data:byte(2)

    -- Calibration message
    data.calibration_message = _CALIBRATION[data.calibration_status]

    -- Has value
    data.has_value = byte_data:byte(3)

    -- Calibration %
    data.calibration_per = byte_data:byte(4)

    -- Calibration % remaining time
    data.calibration_per_remaining_time = byte_data:byte(5)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Compass heading
    data.compass_heading = self:float(byte_data:sub(17, 20))

    -- Compass true heading
    data.compass_true_heading = self:float(byte_data:sub(21, 24))

    -- Soft calibration params 1
    data.soft_calibration_params_1 = self:float(byte_data:sub(33, 36))

    -- Soft calibration params 2
    data.soft_calibration_params_2 = self:float(byte_data:sub(37, 40))

    -- Soft calibration params 3
    data.soft_calibration_params_3 = self:float(byte_data:sub(41, 44))

    -- Hard iron calibration 1
    data.hard_iron_calibration_1 = self:float(byte_data:sub(45, 48))

    -- Hard iron calibration 2
    data.hard_iron_calibration_2 = self:float(byte_data:sub(49, 52))

    -- Hard iron calibration 3
    data.hard_iron_calibration_3 = self:float(byte_data:sub(53, 56))

    -- Hard iron calibration 4
    data.hard_iron_calibration_4 = self:float(byte_data:sub(57, 60))

    -- Hard iron calibration 5
    data.hard_iron_calibration_5 = self:float(byte_data:sub(61, 64))

    -- Hard iron calibration 6
    data.hard_iron_calibration_6 = self:float(byte_data:sub(65, 68))

    -- Hard iron calibration 7
    data.hard_iron_calibration_7 = self:float(byte_data:sub(69, 72))

    -- Hard iron calibration 8
    data.hard_iron_calibration_8 = self:float(byte_data:sub(73, 76))

    -- Hard iron calibration 9
    data.hard_iron_calibration_9 = self:float(byte_data:sub(77, 80))

    byte_data = nil

    return data
end


return Compass
