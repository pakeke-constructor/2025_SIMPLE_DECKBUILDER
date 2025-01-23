
---@meta


local isLoading = true

function isLoadTime()
    return isLoading
end

function finishLoading()
    isLoading = false
end


local QUESTION_REDUCERS = {}
local QUESTION_ANSWERS = {}




local EVENTS = {--[[
    [eventName] -> {func1, func2, ...}
]]}

function defineEvent(event)
    assert(isLoadTime())
    EVENTS[event] = {}
end

function call(event, ...)
    local funcs = assert(EVENTS[event], "Unknown event")
    for _,f in ipairs(funcs) do
        f(...)
    end
end

function on(event, func)
    assert(isLoadTime())
    local arr = assert(EVENTS[event], "Unknown event")
    table.insert(arr, func)
end



local function defineCard(name)
    error("todo: do shit here")
end

local function defineUnitCard()
    
end





setmetatable(_G, {
    __index = error,
    __newindex = error
})

