
-- MySQL

local MySQL = {}


local _MySQL = require('luasql.mysql').mysql()

local ENV = require('aeolus/env')


MySQL.DEFAULT_DB_NAME = 'aelous'
MySQL.DB_NAME = ENV:get('AEOLUS_DB_NAME') or MySQL.DEFAULT_DB_NAME


return MySQL
