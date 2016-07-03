
local Compass = {}


Compass.ID = 72
Compass.SIZE = 80 * 2
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


function Compass:read(hex_data, data_cls)
    local data = {}

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)

    -- Calibration_status
    data.calibration_status = tonumber(hex_data:sub(3, 4), 16)

    -- Calibration message
    data.calibration_message = _CALIBRATION[data.calibration_status]

    -- Has value
    data.has_value = tonumber(hex_data:sub(5, 6), 16)

    -- Calibration %
    data.calibration_per = tonumber(hex_data:sub(7, 8), 16)

    -- Calibration % remaining time
    data.calibration_per_remaining_time = tonumber(hex_data:sub(9, 10), 16)

    -- Timestamp
    data.timestamp = data_cls:double(hex_data:sub(17, 32))

    -- Compass heading
    data.compass_heading = data_cls:float(hex_data:sub(33, 40))

    -- Soft calibration params 1
    data.soft_calibration_params_1 = data_cls:float(hex_data:sub(65, 72))

    -- Soft calibration params 2
    data.soft_calibration_params_2 = data_cls:float(hex_data:sub(73, 80))

    -- Soft calibration params 3
    data.soft_calibration_params_3 = data_cls:float(hex_data:sub(81, 88))

    -- Hard iron calibration 1
    data.hard_iron_calibration_1 = data_cls:float(hex_data:sub(89, 96))

    -- Hard iron calibration 2
    data.hard_iron_calibration_2 = data_cls:float(hex_data:sub(97, 104))

    -- Hard iron calibration 3
    data.hard_iron_calibration_3 = data_cls:float(hex_data:sub(105, 112))

    -- Hard iron calibration 4
    data.hard_iron_calibration_4 = data_cls:float(hex_data:sub(113, 120))

    -- Hard iron calibration 5
    data.hard_iron_calibration_5 = data_cls:float(hex_data:sub(121, 128))

    -- Hard iron calibration 6
    data.hard_iron_calibration_6 = data_cls:float(hex_data:sub(129, 136))

    -- Hard iron calibration 7
    data.hard_iron_calibration_7 = data_cls:float(hex_data:sub(137, 144))

    -- Hard iron calibration 8
    data.hard_iron_calibration_8 = data_cls:float(hex_data:sub(145, 152))

    -- Hard iron calibration 9
    data.hard_iron_calibration_9 = data_cls:float(hex_data:sub(153, 160))

    hex_data = nil

    return data
end


return Compass
