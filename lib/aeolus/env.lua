
local ENV = {}


function ENV.dirname(str)
    if str:match('.-/.-') then
        return string.gsub(str, '(.*/)(.*)', '%1')
    else
        return ''
    end
end

local function _setdir(sub_dir)
    return string.format("%s%s", ENV.PROJECT_DIR, sub_dir)
end


ENV.PROJECT_DIR = string.format("%s../../", ENV.dirname(arg[0]))

ENV.BIN_DIR = os.getenv('AEOLUS_BIN_DIR') or _setdir('bin')
ENV.ETC_DIR = os.getenv('AEOLUS_ETC_DIR') or _setdir('etc')
ENV.LIB_DIR = os.getenv('AEOLUS_LIB_DIR') or _setdir('lib')
ENV.VAR_DIR = os.getenv('AEOLUS_VAR_DIR') or _setdir('var')


return ENV
