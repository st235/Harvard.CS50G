StartState = Class{__includes = BaseState}

function StartState:init()
end

function StartState:enter()
end

function StartState:update(dt)
    if love.keyboard.wasPressed('space') then
        gStateStack:push(BeginLevelState(1))
    end
end

function StartState:render()
    love.graphics.clear(1, 0, 0, 1)
end
