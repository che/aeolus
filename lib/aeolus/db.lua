
-- Aelous database

local DB = {}


DB.Table = require('aeolus/db/table')
DB.Driver = require('aeolus/db/driver')


function DB:settings()
    DB.Driver.Object.DB:settings()
end

function DB:create()
    DB.Driver.Object.DB:create()
end

function DB:delete()
    DB.Driver.Object.DB:delete()
end

function DB:connect()
    return DB.Driver.Object.DB:connect()
end

function DB:close()
    DB.Driver.Object.DB:close()
end


DB.Table.Emmiter = {}

DB.Table.Emmiter.NAME = DB.Table._Emmiter.NAME


function DB.Table.Emmiter:table_exists()
    return DB.Table._Emmiter:table_exists()
end

function DB.Table.Emmiter:exists(mac_address)
    return DB.Table._Emmiter:exists(mac_address)
end

function DB.Table.Emmiter:table_create()
    return DB.Table._Emmiter:table_create(DB.Driver.Object)
end

function DB.Table.Emmiter:insert(data_table)
    return DB.Table._Emmiter:insert(DB.Driver.Object, data_table)
end

function DB.Table.Emmiter:delete(mac_address)
    return DB.Table._Emmiter:delete(DB.Driver.Object, mac_address)
end

function DB.Table.Emmiter:table_delete()
    return DB.Table._Emmiter:table_delete(DB.Driver.Object)
end


DB.Table.Data = {}


function DB.Table.Data:table_exists(mac_address, data_type)
    return DB.Table._Data:table_exists(mac_address, data_type)
end

function DB.Table.Data:table_create(mac_address, data_type)
    return DB.Table._Data:table_create(DB.Driver.Object, mac_address, data_type)
end

function DB.Table.Data:insert(mac_address, data_type, data_table)
    return DB.Table._Data:insert(DB.Driver.Object, mac_address, data_type, data_table)
end

function DB.Table.Data:delete(mac_address, data_type, data_table)
    return DB.Table._Data:delete(DB.Driver.Object, mac_address, data_type, data_table)
end

function DB.Table.Data:table_delete(mac_address, data_type)
    return DB.Table._Data:table_delete(DB.Driver.Object, mac_address, data_type)
end

function DB.Table.Data:table_name(mac_address, data_type)
    return DB.Table._Data:table_name(mac_address, data_type)
end


return DB
