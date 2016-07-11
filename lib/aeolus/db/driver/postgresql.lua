
-- PostgreSQL

local PostgeSQL = {}


local _PostgeSQL = require('luasql.postgres').postgres()

local ENV = require('aeolus/env')


PostgeSQL.DEFAULT_DB_NAME = 'aelous'
PostgeSQL.DB_NAME = ENV:get('AEOLUS_DB_NAME') or PostgeSQL.DEFAULT_DB_NAME


return PostgeSQL
