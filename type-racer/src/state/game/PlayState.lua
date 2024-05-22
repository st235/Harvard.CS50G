PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.matcher = TemplateMatcher(20, 20, 50, 150, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
    self.car = Car(100, 100, 32, 24, 'sedan')
    self.car2 = Car(100, 124, 32, 24, 'sedan', { 169, 169, 169 })
    self.car3 = Car(100, 148, 32, 24, 'hatchback', { 255, 182, 193 })
end

function PlayState:exit()
end

function PlayState:update(dt)
    self.matcher:update(dt)
    self.car:update(dt)
    self.car2:update(dt)
    self.car3:update(dt)
end

function PlayState:render()
    love.graphics.clear(0, 0, 0, 1)

    self.matcher:render()
    self.car:render()
    self.car2:render()
    self.car3:render()
end
