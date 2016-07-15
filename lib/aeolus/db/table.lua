
local Table = {}


Table.Emmiter = require('aeolus/db/table/emmiter')
Table.Data = require('aeolus/db/table/data')

-- Inheritance
setmetatable(Table.Emmiter, {__index = Table})
setmetatable(Table.Data, {__index = Table})


local _driver_object = require('aeolus/db/driver').Object


function Table:driver()
    return _driver_object
end


return Table
