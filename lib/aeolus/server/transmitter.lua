
local Transmitter = {}


require('aeolus/env')
require('aeolus/log')


Transmitter.DEFAULT_IP = '127.0.0.1'
Transmitter.DEFAULT_PORT = 5000

Transmitter.ip = Env:get('AEOLUS_TRANSMITTER_IP') or Transmitter.DEFAULT_IP
Transmitter.port = Env:get('AEOLUS_TRANSMITTER_PORT', Env.number) or Transmitter.DEFAULT_PORT


return Transmitter
