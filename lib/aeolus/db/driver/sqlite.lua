
-- SQLite

local SQLite = {}


local _SQLite = require('luasql.sqlite3').sqlite3()

local ENV = require('aeolus/env')

SQLite.DEFAULT_DB_NAME = 'aelous'
SQLite.DB_NAME = os.getenv('AEOLUS_DB_NAME') or SQLite.DEFAULT_DB_NAME

local DB_FILE = string.format("%s.db", SQLite.DB_NAME)

SQLite.DEFAULT_DB_DIR = ENV.VAR_DIR
SQLite.DB_DIR = string.format("%s/", os.getenv('AEOLUS_DB_DIR') or SQLite.DEFAULT_DB_DIR)

local DB_PATH = string.format("%s%s", SQLite.DB_DIR, DB_FILE)

local connection = nil


SQLite.DB = {}

SQLite.DB.NAME = SQLite.DB_NAME


local function file_exists(path)
    file = io.open(path)

    if file == nil then
        io.close()
        return false
    else
        file:close()
        return true
    end
end

function SQLite.DB:create()
    if file_exists(DB_PATH) then
        print('ERROR: DB already exists!')
        os.exit(1)
    else
        file = io.open(DB_PATH, 'w')
        file:close()
    end
end

function SQLite.DB:delete()
    if file_exists(DB_PATH) then
        os.remove(DB_PATH)
    else
        print('ERROR: DB does not exist!')
        os.exit(1)
    end
end

function SQLite.DB:connect()
    connection = _SQLite:connect(DB_PATH)

    return connection
end

function SQLite.DB:close()
    connection:close()
    _SQLite:close()
end


function SQLite:execute(sql)
    return connection:execute(sql)
end


return SQLite
