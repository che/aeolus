
if Log then
    return
end

require('aeolus/env')
require('logging.file')


local _LEVEL = {
    logging.DEBUG,
    logging.INFO,
    logging.WARN,
    logging.ERROR,
    logging.FATAL
}


local function _define_level(level)
    if level then
        local valid = false

        level = level:upper()

        for i = 1, #_LEVEL do
            if _LEVEL[i] == level then
                valid = true
                break
            end
        end

        if not valid then
            level = nil
        end
    end

    return level
end


local _level = _define_level(Env:get('AEOLUS_LOG_LEVEL')) or logging.ERROR
local _file = Env:get('AEOLUS_LOG_FILE') or 'aeolus.log'
local _dir = Env:get('AEOLUS_LOG_DIR') or Env.DIR
if not (_dir == Env.DIR) then
    _dir = _dir .. Env.SEP
end


Log = logging.file(_dir .. _file)

Log:setLevel(_level)
