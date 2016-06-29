
local Aeolus = require('aeolus')


--Aeolus.DB:create()
Aeolus.DB:connect()

if not Aeolus.DB.Table.Emmiter:table_exists() then
    Aeolus.DB.Table.Emmiter:table_create()
end

local pcap_handle = io.popen(os.getenv('AEOLUS_PCAP_COMMAND'))
local pcap_data = ''

--print(os.date('%Y-%m-%d %H:%M:%S', 1466686980.668728000))
--os.exit()

while pcap_data do
    local values = {}
    pcap_data = pcap_handle:read('*line')

    if pcap_data then
        for i in string.gmatch(string.gsub(pcap_data, '\t', ' '), '%S+') do
            values[#values + 1] = i
        end

        if #values == 10 then
            if not Aeolus.DB.Table.Emmiter:exists(values[2]) then
                Aeolus.DB.Table.Emmiter:insert(values)
            end

            local data_type, data_table, message_error = Aeolus.Data:parse(values[10])

            if not Aeolus.DB.Table.Data:table_exists(values[2], data_type) then
                Aeolus.DB.Table.Data:table_create(values[2], data_type)
            end
--            if Aeolus.DB.Table.Data:table_exists(values[2], data_type) then
--                Aeolus.DB.Table.Data:table_delete(values[2], data_type)
--            end

--            Aeolus.DB.Table.Data:insert(values[2], data_type, data_table)
--            Aeolus.DB.Table.Data:delete(values[2], data_type, data_table)
        end
    end
end

--if Aeolus.DB.Table.Emmiter:table_exists() then
--    Aeolus.DB.Table.Emmiter:table_delete()
--end

pcap_handle:close()
Aeolus.DB:close()

--Aeolus.DB:delete()
