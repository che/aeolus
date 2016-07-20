
if Log then
    return
else
    Log = {}
end


require('aeolus/env')


Log.LEVEL = {}
Log.LEVEL.debug = 'DEBUG'
Log.LEVEL.info = 'INFO'
Log.LEVEL.warn = 'WARN'
Log.LEVEL.error = 'ERROR'
Log.LEVEL.fatal = 'FATAL'

Log.DEFAULT_DEFINED = false
Log.DEFAULT_PRINT = true
Log.DEFAULT_LEVEL = Log.LEVEL.error
Log.DEFAULT_FILE = 'aeolus.log'
Log.DEFAULT_DIR = Env.DIR

local _logging = nil

local _log_level = nil
local _log_level_debug = 0
local _log_level_info = 1
local _log_level_warn = 2
local _log_level_error = 3
local _log_level_fatal = 4

local _LOG_LEVEL = {}
_LOG_LEVEL[Log.LEVEL.debug] = _log_level_debug
_LOG_LEVEL[Log.LEVEL.info] = _log_level_info
_LOG_LEVEL[Log.LEVEL.warn] = _log_level_warn
_LOG_LEVEL[Log.LEVEL.error] = _log_level_error
_LOG_LEVEL[Log.LEVEL.fatal] = _log_level_fatal

local _LOG_FORMAT_STR = '%s %s %s'
local _DATE_FORMAT_STR = '%c'


local function _define_level(lvl)
    if lvl then
        local valid = false

        lvl = lvl:upper()

        for key, _lvl in pairs(Log.LEVEL) do
            if _lvl == lvl then
                valid = true
                break
            end
        end

        if not valid then
            lvl = nil
        end
    end

    return lvl
end

local function _print_log(lvl, message)
    print(_LOG_FORMAT_STR:format(os.date(_DATE_FORMAT_STR, os.time()), lvl, message))
end


Log.defined = Env:get('AEOLUS_LOG', Env.boolean) or Log.DEFAULT_DEFINED
Log.print = Env:get('AEOLUS_LOG_PRINT', Env.boolean) or Log.DEFAULT_PRINT
Log.level = _define_level(Env:get('AEOLUS_LOG_LEVEL')) or Log.DEFAULT_LEVEL
Log.file = Env:get('AEOLUS_LOG_FILE') or Log.DEFAULT_FILE
Log.dir = Env:get('AEOLUS_LOG_DIR') or Log.DEFAULT_DIR
if Log.dir ~= Log.DEFAULT_DIR then
    Log.dir = Log.dir .. Env.SEP
end
_log_level = _LOG_LEVEL[Log.level]


if Log.defined and not Log.print then
    require('logging.file')


    _logging = logging.file(Log.dir .. Log.file)

    _logging:setLevel(Log.level)
end


function Log:debug(message)
    if Log.defined then
        if Log.print then
            if _log_level_debug >= _log_level then
                _print_log(Log.LEVEL.debug, message)
            end
        else
            _logging:debug(message)
        end
    end
end

function Log:info(message)
    if Log.defined then
        if Log.print then
            if _log_level_info >= _log_level then
                _print_log(Log.LEVEL.info, message)
            end
        else
            _logging:info(message)
        end
    end
end

function Log:warn(message)
    if Log.defined then
        if Log.print then
            if _log_level_warn >= _log_level then
                _print_log(Log.LEVEL.warn, message)
            end
        else
            _logging:warn(message)
        end
    end
end

function Log:error(message)
    if Log.defined then
        if Log.print then
            if _log_level_error >= _log_level then
                _print_log(Log.LEVEL.error, message)
            end
        else
            _logging:error(message)
        end
    end
end

function Log:fatal(message)
    if Log.defined then
        if Log.print then
            if _log_level_fatal >= _log_level then
                _print_log(Log.LEVEL.fatal, message)
            end
        else
            _logging:fatal(message)
        end
    end
end
