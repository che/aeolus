
local aeolus = require('aeolus')

--print(aeolus.db.driver.NAME)

--print(aeolus.db.driver.obj.DB_DIR)

--aeolus.db:create()
aeolus.db:connect()
aeolus.db.table.emmiter:table_create()

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
            aeolus.db.table.emmiter:insert(values)

            local data_type, data_table, message_error = aeolus.data:parse(values[10])

            aeolus.db.table.data:table_create(values[2], data_type)
--            aeolus.db.table.data:table_delete(values[2], data_type)

--!!            if aeolus.db.table.data:exists(values[2], data_type) then
                aeolus.db.table.data:insert(values[2], data_type, data_table)
--                aeolus.db.table.data:delete(values[2], data_type, data_table)
--!!            end
        end
    end
end

pcap_handle:close()
aeolus.db:close()

--aeolus.db:delete()
