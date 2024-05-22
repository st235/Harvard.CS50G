PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.label = Label(20, 20, 50, 150, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
end

function PlayState:exit()
end

function PlayState:update(dt)
end

function PlayState:render()
    love.graphics.clear(1, 0, 0, 1)
    self.label:render()
end
