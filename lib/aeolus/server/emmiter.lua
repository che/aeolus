
local Emmiter = {}


local ENV = require('aeolus/env')


Emmiter.DEFAULT_IP = '127.0.0.1'
Emmiter.DEFAULT_PORT = 5000

Emmiter.ip = ENV:get('AEOLUS_EMMITER_IP') or Emmiter.DEFAULT_IP
Emmiter.port = ENV:get('AEOLUS_EMMITER_PORT') or Emmiter.DEFAULT_PORT


return Emmiter
