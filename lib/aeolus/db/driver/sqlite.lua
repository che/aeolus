
-- SQLite

local SQLite = {}


local _SQLite = require('luasql.sqlite3').sqlite3()

local _Env = require('aeolus/env')

SQLite.DEFAULT_DB_NAME = 'aelous'
SQLite.DB_NAME = os.getenv('AEOLUS_DB_NAME') or SQLite.DEFAULT_DB_NAME

local _DB_FILE = (SQLite.DB_NAME .. '.db')

SQLite.DEFAULT_DB_DIR = _Env.VAR_DIR
SQLite.DB_DIR = ('%s/'):format(os.getenv('AEOLUS_DB_DIR') or SQLite.DEFAULT_DB_DIR)

local _DB_PATH = (SQLite.DB_DIR .. _DB_FILE)

local connection = nil


SQLite.DB = {}

SQLite.DB.NAME = SQLite.DB_NAME


local function _file_exists(path)
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
    if _file_exists(_DB_PATH) then
        print('ERROR: DB already exists!')
        os.exit(1)
    else
        file = io.open(_DB_PATH, 'w')
        file:close()
    end
end

function SQLite.DB:delete()
    if _file_exists(_DB_PATH) then
        os.remove(_DB_PATH)
    else
        print('ERROR: DB does not exist!')
        os.exit(1)
    end
end

function SQLite.DB:connect()
    connection = _SQLite:connect(_DB_PATH)

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
