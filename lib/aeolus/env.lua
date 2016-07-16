
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


local function _dir()
    if arg and arg[0] then
        return Env:dirname(arg[0])
    else
        return '.'
    end
end


function Env:dirname(str)
    if str:match('.-/.-') then
        return str:gsub('(.*/)(.*)', '%1')
    else
        return ''
    end
end

function Env:get(var, _type)
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
end


Env.SEP = '/'
Env.DIR = _dir() .. Env.SEP
