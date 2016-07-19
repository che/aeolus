
local TE = {}


TE.NAME = 'te'


local _SQL_TABLE_STRUCTURE = [[
        data_valid INTEGER(1) NOT NULL,
        timestamp FLOAT(8) NOT NULL,
        linear_speed_x FLOAT(4) NOT NULL,
        linear_speed_y FLOAT(4) NOT NULL,
        linear_speed_z FLOAT(4) NOT NULL,
        linear_acceleration_x FLOAT(4) NOT NULL,
        linear_acceleration_y FLOAT(4) NOT NULL,
        linear_acceleration_z FLOAT(4) NOT NULL,
        potential_energy FLOAT(4) NOT NULL,
        kinetic_energy FLOAT(4) NOT NULL,
        total_energy FLOAT(4) NOT NULL,
        potential_energy_rate FLOAT(4) NOT NULL,
        kinetic_energy_rate FLOAT(4) NOT NULL,
        total_energy_rate FLOAT(4) NOT NULL,
        created_at FLOAT(8) NOT NULL
]]

local _SQL_INSERT = [[
    INSERT INTO %s (
        data_valid,
        timestamp,
        linear_speed_x,
        linear_speed_y,
        linear_speed_z,
        linear_acceleration_x,
        linear_acceleration_y,
        linear_acceleration_z,
        potential_energy,
        kinetic_energy,
        total_energy,
        potential_energy_rate,
        kinetic_energy_rate,
        total_energy_rate,
        created_at)
        VALUES ('%d','%.8f', '%.16f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.16f',
                '%.16f', '%.16f', '%.16f', '%.16f', '%.8f');
]]


function TE:sql_table_structure()
    return _SQL_TABLE_STRUCTURE
end

function TE:insert(table_name, data_table)
    return self:driver():execute(_SQL_INSERT:format(table_name,
                                                    data_table.data_valid,
                                                    data_table.timestamp,
                                                    data_table.linear_speed_x,
                                                    data_table.linear_speed_y,
                                                    data_table.linear_speed_z,
                                                    data_table.linear_acceleration_x,
                                                    data_table.linear_acceleration_y,
                                                    data_table.linear_acceleration_z,
                                                    data_table.potential_energy,
                                                    data_table.kinetic_energy,
                                                    data_table.total_energy,
                                                    data_table.potential_energy_rate,
                                                    data_table.kinetic_energy_rate,
                                                    data_table.total_energy_rate,
                                                    os.time()))
end

function TE:delete(table_name, data_table)
    return nil
end


return TE
