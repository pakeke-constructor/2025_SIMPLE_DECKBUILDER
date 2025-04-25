
---@class db
--- db stands for DeckBuilder
local db = {}


local isLoading = true

---@return boolean
function db.isLoadTime()
    return isLoading
end

function db.finishLoading()
    isLoading = false
end




--[[
OMG!!! You are overwriting require fucntion!!!!

Yeah, because luaLS checks for the name require.
dumb, i know i know
]]
do
local stack = {""}
local oldRequire = require
local function stackRequire(path)
    table.insert(stack, path)
    log.trace("require: ", path)
    local result = oldRequire(path)
    table.remove(stack)
    return result
end


function _G.require(path)
    if (path:sub(1,1) == ".") then
        -- its a relative-require!
        local lastPath = stack[#stack]
        if lastPath:find("%.") then -- then its a valid path1
            local subpath = lastPath:gsub('%.[^%.]+$', '')
            return stackRequire(subpath .. path)
        else
            -- we are in root-folder; remove the dot and require
            return stackRequire(path:sub(2))
        end
    else
        return stackRequire(path)
    end
end

end



function db.walkDirectory(path, func)
    local info = love.filesystem.getInfo(path)
    if not info then return end

    if info.type == "file" then
        func(path)
    elseif info.type == "directory" then
        local dirItems = love.filesystem.getDirectoryItems(path)
        for _, pth in ipairs(dirItems) do
            db.walkDirectory(path .. "/" .. pth, func)
        end
    end
end


function db.requireFolder(path)
    db.walkDirectory(path:gsub("%.", "/"), function(pth)
        if pth:sub(-5,-1) == ".lua" then
            pth = pth:sub(1, -5)
            log.trace("loading file:", path)
            require(pth:gsub("%/", "."))
        end
    end)
end




function db.defineEvent()
    assert(db.isLoadTime())
    local funcs = objects.Array()

    local function call(...)
        for _,f in ipairs(funcs) do
            f(...)
        end
    end

    local function on(func)
        assert(db.isLoadTime())
        funcs:add(func)
    end

    return call, on
end




function db.defineCard(name, cardType)
    error("todo: do shit here")
end

function db.defineUnitCard(name)
    error("todo: do shit here")
end


function db.defineUnit()
    
end



return db
