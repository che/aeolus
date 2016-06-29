
local Driver = {}


Driver.DEFAULT_NAME = 'sqlite'

Driver.NAME = os.getenv('AEOLUS_DB_DRIVER') or Driver.DEFAULT_NAME

Driver.Object = require(string.format('aeolus/db/driver/%s', Driver.NAME))


return Driver
