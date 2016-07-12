
-- MySQL

local MySQL = {}


local _MySQL = require('luasql.mysql').mysql()

local ENV = require('aeolus/env')


MySQL.DEFAULT_DB_NAME = 'aelous'
MySQL.DB_NAME = ENV:get('AEOLUS_DB_NAME') or MySQL.DEFAULT_DB_NAME

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
