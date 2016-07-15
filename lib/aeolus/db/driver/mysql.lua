
-- MySQL

local MySQL = {}


require('aeolus/env')
require('aeolus/log')

local _MySQL = require('luasql.mysql').mysql()


MySQL.DEFAULT_DB_NAME = 'aeolus'
MySQL.DB_NAME = Env:get('AEOLUS_DB_NAME') or MySQL.DEFAULT_DB_NAME

local _connection = nil


MySQL.DB = {}

MySQL.DB.NAME = MySQL.DB_NAME


function MySQL.DB:settings()
    return nil
end

function MySQL.DB:create()
    return nil
end

function MySQL.DB:delete()
    return nil
end

function MySQL.DB:connect()
    return nil
end

function MySQL.DB:close()
    return nil
end


function MySQL:execute(sql)
    return nil
end


return MySQL
