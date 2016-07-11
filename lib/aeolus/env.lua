
local ENV = {}


local function _setdir(sub_dir)
    return ENV.PROJECT_DIR .. sub_dir
end


function ENV:dirname(str)
    if str:match('.-/.-') then
        return str:gsub('(.*/)(.*)', '%1')
    else
        return ''
    end
end

function ENV:set(var)
    return var
end

function ENV:get(var)
    if os.getenv then
        return os.getenv(var)
    else
        return nil
    end
end


ENV.PROJECT_DIR = ('%s../'):format(ENV:dirname(arg[0]))

ENV.BIN_DIR = ENV:get('AEOLUS_BIN_DIR') or _setdir('bin')
ENV.ETC_DIR = ENV:get('AEOLUS_ETC_DIR') or _setdir('etc')
ENV.LIB_DIR = ENV:get('AEOLUS_LIB_DIR') or _setdir('lib')
ENV.VAR_DIR = ENV:get('AEOLUS_VAR_DIR') or _setdir('var')


return ENV
