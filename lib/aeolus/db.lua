
-- Aelous database

local db = {}


db.env = require('aeolus/env')
db.table = require('aeolus/db/table')
db.driver = require('aeolus/db/driver')


function db:create()
    db.driver.obj.db:create()
end

function db:delete()
    db.driver.obj.db:delete()
end

function db:connect()
    return db.driver.obj.db:connect()
end

function db:close()
    db.driver.obj.db:close()
end


db.table.emmiter = {}

db.table.emmiter.NAME = db.table._emmiter.NAME


function db.table.emmiter:table_create()
    return db.table._emmiter:table_create(db.driver.obj)
end

function db.table.emmiter:insert(values)
    return db.table._emmiter:insert(db.driver.obj, values)
end

function db.table.emmiter:delete(source_mac)
    return db.table._emmiter:delete(db.driver.obj, source_mac)
end

function db.table.emmiter:table_delete()
    return db.table._emmiter:table_delete(db.driver.obj)
end


db.table.data = {}

function db.table.data:table_create(source_mac, data_type)
    return db.table._data:table_create(db.driver.obj, source_mac, data_type)
end

function db.table.data:insert(source_mac, data_type, data_table)
    return db.table._data:insert(db.driver.obj, source_mac, data_type, data_table)
end

function db.table.data:delete(source_mac, data_type, data_table)
    return db.table._data:delete(db.driver.obj, source_mac, data_type, data_table)
end

function db.table.data:table_delete(source_mac, data_type)
    return db.table._data:table_delete(db.driver.obj, source_mac, data_type)
end

function db.table.data:table_name(source_mac, data_type)
    return db.table._data:table_name(source_mac, data_type)
end


return db
