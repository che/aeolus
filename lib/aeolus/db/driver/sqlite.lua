
-- SQLite

local sqlite = {}


local _sqlite = require('luasql.sqlite3').sqlite3()

local env = require('aeolus/env')

sqlite.DEFAULT_DB_NAME = 'aelous'
sqlite.DB_NAME = os.getenv('AEOLUS_DB_NAME') or sqlite.DEFAULT_DB_NAME

local DB_FILE = string.format("%s.db", sqlite.DB_NAME)

sqlite.DEFAULT_DB_DIR = env.VAR_DIR
sqlite.DB_DIR = string.format("%s/", os.getenv('AEOLUS_DB_DIR') or sqlite.DEFAULT_DB_DIR)

local DB_PATH = string.format("%s%s", sqlite.DB_DIR, DB_FILE)


sqlite.db = {}

sqlite.db.connection = nil

sqlite.db.NAME = sqlite.DB_NAME


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

function sqlite.db:create()
    if file_exists(DB_PATH) then
        print('ERROR: DB already exists!')
        os.exit(1)
    else
        file = io.open(DB_PATH, 'w')
        file:close()
    end
end

function sqlite.db:delete()
    if file_exists(DB_PATH) then
        os.remove(DB_PATH)
    else
        print('ERROR: DB does not exist!')
        os.exit(1)
    end
end

function sqlite.db:connect()
    sqlite.db.connection = _sqlite:connect(DB_PATH)

    return sqlite.db.connection
end

function sqlite.db:close()
  sqlite.db.connection:close()
  _sqlite:close()
end


function sqlite:execute(sql)
  return sqlite.db.connection:execute(sql)
end


return sqlite
