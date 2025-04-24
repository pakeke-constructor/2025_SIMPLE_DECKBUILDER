

require("db")



local state = GAME



function love.draw()
    state.draw()
end


function love.update(dt)
    state.update(dt)
end

