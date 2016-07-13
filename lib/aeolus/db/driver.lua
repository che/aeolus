
local Driver = {}


local Env = require('aeolus/env')


Driver.DEFAULT_NAME = 'sqlite'

Driver.NAME = Env:get('AEOLUS_DB_DRIVER') or Driver.DEFAULT_NAME

Driver.Object = require(('aeolus/db/driver/%s'):format(Driver.NAME))


return Driver
