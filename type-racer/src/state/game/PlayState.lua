PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.level = Level(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 1)
    self.level:start()
end

function PlayState:exit()
end

function PlayState:update(dt)
    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end
