
if Env then
    return
else
    Env = {}
end


Env.string = 0
Env.number = 1
Env.boolean = 2


local _FALSE_STR = 'false'
local _TRUE_STR = 'true'


local function _setdir(sub_dir)
    return Env.PROJECT_DIR .. sub_dir .. Env.SEP
end


function Env:dirname(str)
    if str:match('.-/.-') then
        return str:gsub('(.*/)(.*)', '%1')
    else
        return ''
    end
end

function Env:get(var, _type)
    if os.getenv then
        local value = os.getenv(var)

        if _type == nil or _type == self.string then
            return value
        elseif _type == self.number then
            return tonumber(value)
        elseif _type == self.boolean then
            if value == _TRUE_STR or tonumber(value) == 1 then
                return true
            elseif value == _FALSE_STR or tonumber(value) == 0 then
                return false
            else
                return nil
            end
        end
    else
        return nil
    end
end


Env.SEP = '/'

Env.PROJECT_DIR = Env:dirname(arg[0]) .. '..' .. Env.SEP
Env.BIN_DIR = Env:get('AEOLUS_BIN_DIR') or _setdir('bin')
Env.ETC_DIR = Env:get('AEOLUS_ETC_DIR') or _setdir('etc')
Env.LIB_DIR = Env:get('AEOLUS_LIB_DIR') or _setdir('lib')
Env.VAR_DIR = Env:get('AEOLUS_VAR_DIR') or _setdir('var')
