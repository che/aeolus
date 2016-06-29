
local driver = {}


driver.DEFAULT_NAME = 'sqlite'

driver.NAME = os.getenv('AEOLUS_DB_DRIVER') or driver.DEFAULT_NAME

driver.obj = require(string.format('aeolus/db/driver/%s', driver.NAME))


return driver
