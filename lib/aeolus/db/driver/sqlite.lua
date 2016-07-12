
-- SQLite

local SQLite = {}


local _SQLite = require('luasql.sqlite3').sqlite3()

local ENV = require('aeolus/env')


SQLite.DEFAULT_DB_NAME = 'aelous'
SQLite.DB_NAME = ENV:get('AEOLUS_DB_NAME') or SQLite.DEFAULT_DB_NAME

SQLite.DEFAULT_DB_DIR = ENV.VAR_DIR
SQLite.DB_DIR = ('%s/'):format(ENV:get('AEOLUS_DB_DIR') or SQLite.DEFAULT_DB_DIR)

local _DB_FILE = (SQLite.DB_NAME .. '.db')
local _DB_PATH = (SQLite.DB_DIR .. _DB_FILE)

local _SETTINGS = {
    'PRAGMA synchronous = NORMAL;',
    'PRAGMA auto_vacuum = NONE;',
    'PRAGMA journal_mode = WAL;',
    'PRAGMA page_size = 16384;',
    'PRAGMA cache_size = 4096;',
    'PRAGMA threads = 4;'
}

local _TRANSACTION = {}
_TRANSACTION.begin = 'BEGIN;'
_TRANSACTION.commit = 'COMMIT;'
_TRANSACTION.rollback = 'ROLLBACK;'

local _FILE_W_MODE = 'w'

local _connection = nil


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


function SQLite.DB:settings()
    if _connection then
        for i = 1, #_SETTINGS do
            _connection:execute(_SETTINGS[i])
        end

        return true
    else
        return false
    end
end

function SQLite.DB:create()
    if _file_exists(_DB_PATH) then
        print('ERROR: DB already exists!')
        os.exit(1)
    else
        file = io.open(_DB_PATH, _FILE_W_MODE)
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
    _connection = _SQLite:connect(_DB_PATH)

    return _connection
end

function SQLite.DB:close()
    if _connection then
        _connection:close()
    end

    _SQLite:close()
end


function SQLite:execute(sql)
    if _connection then
        local status = nil

        _connection:execute(_TRANSACTION.begin)
        status = _connection:execute(sql)

        if status then
            _connection:execute(_TRANSACTION.commit)

            return true
        else
            _connection:execute(_TRANSACTION.rollback)

            return false
        end
    else
        return nil
    end
end


return SQLite
