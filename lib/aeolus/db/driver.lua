
local Driver = {}


require('aeolus/env')
require('aeolus/log')


Driver.DEFAULT_NAME = 'sqlite'

Driver.NAME = Env:get('AEOLUS_DB_DRIVER') or Driver.DEFAULT_NAME

Driver.Object = require(('aeolus/db/driver/%s'):format(Driver.NAME))
Log:debug(('DB Driver %s was loaded'):format(Driver.NAME))


return Driver
