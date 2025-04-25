

require("db")


setmetatable(_G, {
    __index = function(t,k)
        error("Accessed undefined var: " .. k)
    end,
    __newindex = function(t,k,v)
        error("Created global: " .. k)
    end
})



local state = COMBAT



function love.draw()
    state.draw()
end


function love.update(dt)
    state.update(dt)
end

