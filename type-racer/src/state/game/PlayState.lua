PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.matcher = TemplateMatcher(20, 20, 50, 150, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
end

function PlayState:exit()
end

function PlayState:update(dt)
    self.matcher:update(dt)
end

function PlayState:render()
    love.graphics.clear(0, 0, 0, 1)
    self.matcher:render()
end
