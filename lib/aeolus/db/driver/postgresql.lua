
-- PostgreSQL

local PostgeSQL = {}


require('aeolus/env')
require('aeolus/log')

local _PostgeSQL = require('luasql.postgres').postgres()


PostgeSQL.DEFAULT_DB_NAME = 'aelous'
PostgeSQL.DB_NAME = Env:get('AEOLUS_DB_NAME') or PostgeSQL.DEFAULT_DB_NAME

local _connection = nil


PostgeSQL.DB = {}

PostgeSQL.DB.NAME = PostgeSQL.DB_NAME


function PostgeSQL.DB:settings()
    return nil
end

function PostgeSQL.DB:create()
    return nil
end

function PostgeSQL.DB:delete()
    return nil
end

function PostgeSQL.DB:connect()
    return nil
end

function PostgeSQL.DB:close()
    return nil
end


function PostgeSQL:execute(sql)
    return nil
end


return PostgeSQL
