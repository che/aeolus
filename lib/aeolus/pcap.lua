
local PCAP = {}


local Aeolus = require('aeolus')

local pcap_handle = nil


function PCAP:init()
    pcap_handle = io.popen(os.getenv('AEOLUS_PCAP_COMMAND'))

--    Aeolus.DB:create()
    Aeolus.DB:connect()

    if not Aeolus.DB.Table.Emmiter:table_exists() then
        Aeolus.DB.Table.Emmiter:table_create()
    end

--print(os.date('%Y-%m-%d %H:%M:%S', 1466686980.668728000))
--os.exit()
end

function PCAP:read()
    local pcap_data = ''

    while pcap_data do
        local values = {}

        pcap_data = pcap_handle:read('*line')

        if pcap_data then
            for i in string.gmatch(pcap_data:gsub('\t', ' '), '%S+') do
                values[#values + 1] = i
            end

            if #values == 10 then
                if not Aeolus.DB.Table.Emmiter:exists(values[2]) then
                    Aeolus.DB.Table.Emmiter:insert(values)
                end

                self:parse(values)
            end
        end
    end
end

function PCAP:parse(values)

--print(values[10])

    local data, error_message = Aeolus.Data:parse(values[10])

--print(data)

    for data_type, data_table in pairs(data) do
--        print(data_type)

        if not Aeolus.DB.Table.Data:table_exists(values[2], data_type) then
            Aeolus.DB.Table.Data:table_create(values[2], data_type)
        end
--os.exit()
--            if Aeolus.DB.Table.Data:table_exists(values[2], data_type) then
--                Aeolus.DB.Table.Data:table_delete(values[2], data_type)
--            end

            Aeolus.DB.Table.Data:insert(values[2], data_type, data_table)
--            Aeolus.DB.Table.Data:delete(values[2], data_type, data_table)
    end
end

function PCAP:close()
--    if Aeolus.DB.Table.Emmiter:table_exists() then
--        Aeolus.DB.Table.Emmiter:table_delete()
--    end

    pcap_handle:close()
    Aeolus.DB:close()

--    Aeolus.DB:delete()
end


PCAP:init()

PCAP:read()

PCAP:close()
