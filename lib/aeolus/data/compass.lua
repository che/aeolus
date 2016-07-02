
local Compass = {}


Compass.ID = 72
Compass.SIZE = 80 * 2
Compass.NAME = 'compass'

local CALIBRATION = {}
CALIBRATION[4] = 'Calibrating'
CALIBRATION[3] = 'Calibration'
CALIBRATION[2] = 'Just finished'
CALIBRATION[1] = 'No calibration'
CALIBRATION[-1] = 'Too few data'
CALIBRATION[-2] = 'Field weak'
CALIBRATION[-3] = 'Field distored'
CALIBRATION[-4] = 'Error very high'


function Compass:read(hex_data)
    local data = {}

print(self.NAME)
print(#hex_data)
print(hex_data)

    -- Data valid
    data.data_valid = tonumber(hex_data:sub(1, 2), 16)
print(data.data_valid)

    -- Calibration_status
    data.calibration_status = tonumber(hex_data:sub(3, 4), 16)
print(data.calibration_status)

    -- Calibration message
    data.calibration_message = CALIBRATION[data.calibration_status]
print(data.calibration_message)


    -- Has value
    data.has_value = tonumber(hex_data:sub(5, 6), 16)
print(data.has_value)

    -- Calibration %
    data.calibration_per = tonumber(hex_data:sub(7, 8), 16)
print(data.calibration_per)

    -- Calibration % remaining time
    data.calibration_per_remaining_time = tonumber(hex_data:sub(9, 10), 16)
print(data.calibration_per_remaining_time)

    -- Timestamp
    data.timestamp = hex_data:sub(17, 32)
print(data.timestamp)

    -- Compass heading
    data.compass_heading = hex_data:sub(33, 40)
print(data.compass_heading)

    -- Soft calibration params 1
    data.soft_calibration_params_1 = hex_data:sub(65, 72)
print(data.soft_calibration_params_1)

    -- Soft calibration params 2
    data.soft_calibration_params_2 = hex_data:sub(73, 80)
print(data.soft_calibration_params_2)

    -- Soft calibration params 3
    data.soft_calibration_params_3 = hex_data:sub(81, 88)
print(data.soft_calibration_params_3)

    -- Hard iron calibration 1
    data.hard_iron_calibration_1 = hex_data:sub(89, 96)
print(data.hard_iron_calibration_1)

    -- Hard iron calibration 2
    data.hard_iron_calibration_2 = hex_data:sub(97, 104)
print(data.hard_iron_calibration_2)

    -- Hard iron calibration 3
    data.hard_iron_calibration_3 = hex_data:sub(105, 112)
print(data.hard_iron_calibration_3)

    -- Hard iron calibration 4
    data.hard_iron_calibration_4 = hex_data:sub(113, 120)
print(data.hard_iron_calibration_4)

    -- Hard iron calibration 5
    data.hard_iron_calibration_5 = hex_data:sub(121, 128)
print(data.hard_iron_calibration_5)

    -- Hard iron calibration 6
    data.hard_iron_calibration_6 = hex_data:sub(129, 136)
print(data.hard_iron_calibration_6)

    -- Hard iron calibration 7
    data.hard_iron_calibration_7 = hex_data:sub(137, 144)
print(data.hard_iron_calibration_7)

    -- Hard iron calibration 8
    data.hard_iron_calibration_8 = hex_data:sub(145, 152)
print(data.hard_iron_calibration_8)

    -- Hard iron calibration 9
    data.hard_iron_calibration_9 = hex_data:sub(153, 160)
print(data.hard_iron_calibration_9)

    hex_data = nil

    return data
end


return Compass
