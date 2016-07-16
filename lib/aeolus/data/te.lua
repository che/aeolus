
-- Total energy

local TE = {}


TE.ID = 74
TE.SIZE = 64
TE.NAME = 'te'


function TE:read(byte_data)
    local data = {}

    -- Data valid
    data.data_valid = byte_data:byte(1)

    -- Timestamp
    data.timestamp = self:timestamp(byte_data:sub(9, 16))

    -- Linear speed X
    data.linear_speed_x = self:float(byte_data:sub(17, 20))

    -- Linear speed Y
    data.linear_speed_y = self:float(byte_data:sub(21, 24))

    -- Linear speed Z
    data.linear_speed_z = self:float(byte_data:sub(25, 28))

    -- Linear acceleration X
    data.linear_acceleration_x = self:float(byte_data:sub(29, 32))

    -- Linear acceleration Y
    data.linear_acceleration_y = self:float(byte_data:sub(33, 36))

    -- Linear acceleration Z
    data.linear_acceleration_z = self:float(byte_data:sub(37, 40))

    -- Potential energy
    data.potential_energy = self:float(byte_data:sub(41, 44))

    -- Kinetic energy
    data.kinetic_energy = self:float(byte_data:sub(45, 48))

    -- Total energy
    data.total_energy = self:float(byte_data:sub(49, 52))

    -- Potential energy rate
    data.potential_energy_rate = self:float(byte_data:sub(53, 56))

    -- Kinetic energy rate
    data.kinetic_energy_rate = self:float(byte_data:sub(57, 60))

    -- Total energy rate
    data.total_energy_rate = self:float(byte_data:sub(61, 64))


    byte_data = nil

    return data
end


return TE
