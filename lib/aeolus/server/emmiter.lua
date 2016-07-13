
local Emmiter = {}


local Env = require('aeolus/env')


Emmiter.DEFAULT_IP = '127.0.0.1'
Emmiter.DEFAULT_PORT = 5000

Emmiter.ip = Env:get('AEOLUS_EMMITER_IP') or Emmiter.DEFAULT_IP
Emmiter.port = Env:get('AEOLUS_EMMITER_PORT', Env.number) or Emmiter.DEFAULT_PORT


return Emmiter
