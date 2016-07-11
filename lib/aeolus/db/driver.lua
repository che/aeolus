
local Driver = {}


local ENV = require('aeolus/env')


Driver.DEFAULT_NAME = 'sqlite'

Driver.NAME = ENV:get('AEOLUS_DB_DRIVER') or Driver.DEFAULT_NAME

Driver.Object = require(('aeolus/db/driver/%s'):format(Driver.NAME))


return Driver
