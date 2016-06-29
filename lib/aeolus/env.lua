
local env = {}


function env.dirname(str)
    if str:match('.-/.-') then
        return string.gsub(str, '(.*/)(.*)', '%1')
    else
        return ''
    end
end

local function setdir(sub_dir)
    return string.format("%s%s", env.PROJECT_DIR, sub_dir)
end


env.PROJECT_DIR = string.format("%s../../", env.dirname(arg[0]))

env.BIN_DIR = os.getenv('AEOLUS_BIN_DIR') or setdir('bin')
env.ETC_DIR = os.getenv('AEOLUS_ETC_DIR') or setdir('etc')
env.LIB_DIR = os.getenv('AEOLUS_LIB_DIR') or setdir('lib')
env.VAR_DIR = os.getenv('AEOLUS_VAR_DIR') or setdir('var')


return env
