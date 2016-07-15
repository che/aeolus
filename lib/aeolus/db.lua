
-- Aelous database

local DB = {}


DB.Table = require('aeolus/db/table')

-- Inheritance
setmetatable(DB, {__index = DB.Table:driver().DB})


return DB
