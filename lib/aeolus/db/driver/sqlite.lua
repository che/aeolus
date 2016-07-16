
-- SQLite

local SQLite = {}


require('aeolus/env')
require('aeolus/log')

local _SQLite = require('luasql.sqlite3').sqlite3()


SQLite.DEFAULT_DB_NAME = 'aeolus'
SQLite.DB_NAME = Env:get('AEOLUS_DB_NAME') or SQLite.DEFAULT_DB_NAME

SQLite.DEFAULT_DB_DIR = Env.DIR
SQLite.DB_DIR = Env:get('AEOLUS_DB_DIR') or SQLite.DEFAULT_DB_DIR
if not (SQLite.DB_DIR == SQLite.DEFAULT_DB_DIR) then
    SQLite.DB_DIR = SQLite.DB_DIR .. Env.SEP
end


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


local function _db_file_exists(path)
    file = io.open(path)

    if file == nil then
        io.close()
        Log:debug(('DB Driver SQLite: file %s does not exist'):format(path))

        return false
    else
        file:close()
        Log:debug(('DB Driver SQLite: file %s exists'):format(path))

        return true
    end
end


function SQLite.DB:settings()
    if _connection then
        for i = 1, #_SETTINGS do
            _connection:execute(_SETTINGS[i])
        end
        Log:debug('DB Driver SQLite: settings was setuped')

        return true
    else
        Log:warn('DB Driver SQLite: settings was not setuped')

        return false
    end
end

function SQLite.DB:create()
    if _db_file_exists(_DB_PATH) then
        Log:fatal(('DB Driver SQLite: DB %s already exists!'):format(SQLite.DB_NAME))
        os.exit(1)
    else
        file = io.open(_DB_PATH, _FILE_W_MODE)
        file:close()
        Log:debug(('DB Driver SQLite: DB %s was created'):format(SQLite.DB_NAME))
    end

    return true
end

function SQLite.DB:delete()
    if _db_file_exists(_DB_PATH) then
        os.remove(_DB_PATH)
        Log:debug(('DB Driver SQLite: DB %s was deleted'):format(SQLite.DB_NAME))
    else
        Log:fatal(('DB Driver SQLite: DB %s does not exist!'):format(SQLite.DB_NAME))
        os.exit(1)
    end

    return true
end

function SQLite.DB:connect()
    _connection = _SQLite:connect(_DB_PATH)
    Log:debug('DB Driver SQLite: connection was created')

    return _connection
end

function SQLite.DB:close()
    if _connection then
        _connection:close()
        Log:debug('DB Driver SQLite: DBconnection was closed')
    end

    _SQLite:close()
    Log:debug('DB Driver SQLite: DB was created')

    return true
end


function SQLite:execute(sql)
    if _connection then
        local status = nil

        _connection:execute(_TRANSACTION.begin)
        status = _connection:execute(sql)

        if status then
            _connection:execute(_TRANSACTION.commit)
            Log:debug('DB Driver SQLite: SQL was executed successfully')
        else
            _connection:execute(_TRANSACTION.rollback)
            Log:warn('DB Driver SQLite: SQL was executed unsuccessfully')
        end

        return status
    else
        return nil
    end
end


return SQLite
