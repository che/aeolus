
-- Add, remove, manage waypoints

local WP = {}


WP.ID = 91
WP.SIZE = 32
WP.NAME = 'wp'

local _ACTION = {}
_ACTION[0] = 'Clear all waypoints'
_ACTION[1] = 'Clear single waypoints'
_ACTION[2] = 'Set destination waypoint'
_ACTION[3] = 'Set previous waypoint'
_ACTION[4] = 'Add waypoint'


function WP:read(byte_data)
    local data = {}

    -- Action
    data.action = byte_data:byte(1)

    -- Action name
    data.action_name = _ACTION[data.action]

    -- Target point index for action
    data.target_point_index = self:float(byte_data:sub(9, 12))

    -- Latitude (for action 4)
    data.latitude = self:float(byte_data:sub(17, 20))

    -- Longitude (for action 4)
    data.longitude = self:float(byte_data:sub(21, 24))

    byte_data = nil

    return data
end


return WP
