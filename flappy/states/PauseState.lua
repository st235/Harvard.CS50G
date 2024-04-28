local PAUSE_IMAGE = love.graphics.newImage('pause.png')

PauseState = Class{__includes = BaseState}

function PauseState:init()
    self.image = PAUSE_IMAGE
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
end

function PauseState:enter(params)
    self.savedParams = params
    sounds['music']:pause()
    sounds['pause']:play()
end

function PauseState:exit()
    sounds['music']:play()
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then
        gStateMachine:change('play', self.savedParams)
    end
end

function PauseState:render()
    love.graphics.draw(self.image, (VIRTUAL_WIDTH - self.width) / 2, (VIRTUAL_HEIGHT - self.height) / 2)
end
