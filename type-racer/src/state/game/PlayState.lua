PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.matcher = TemplateMatcher(20, 20, 50, 150, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
    self.car = Car(VIRTUAL_WIDTH - 32, VIRTUAL_HEIGHT - 24 * 3, 32, 24, { 1, 2 })
    self.car2 = Car(VIRTUAL_WIDTH - 32, VIRTUAL_HEIGHT - 24 * 2, 32, 24, { 3, 4 }, { 169, 169, 169 })
    self.car3 = Car(VIRTUAL_WIDTH - 32, VIRTUAL_HEIGHT - 24 * 1, 32, 24, { 9, 10 }, { 255, 182, 193 })
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
