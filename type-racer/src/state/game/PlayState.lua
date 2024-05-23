PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.matcher = TemplateMatcher(20, 20, 50, 150, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
    
    local car = Car(0, 0, 32, 24, { 1, 2 })
    self.lane = Lane(32, VIRTUAL_HEIGHT - 32, VIRTUAL_WIDTH - 64, 32, car)

    self.matcher.onMatch = function(s, p)
        self.lane:setProgress(p)
    end
end

function PlayState:exit()
end

function PlayState:update(dt)
    self.matcher:update(dt)
    self.lane:update(dt)
end

function PlayState:render()
    love.graphics.clear(0, 0, 0, 1)

    self.matcher:render()
    self.lane:render()
end
