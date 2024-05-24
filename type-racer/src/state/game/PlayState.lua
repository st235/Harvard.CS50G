PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter()
    self.level = Level(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 1)

    self.level.onWin = function()
        gStateStack:push(VictoryState('Victory!!1!'))
    end

    self.level.onLose = function(coords)
        local playerX, playerY = coords[1], coords[2]

        gStateStack:push(GameOverState("Game Over...", playerX, playerY, 20))
    end

    self.isStarted = false
end

function PlayState:exit()
end

function PlayState:update(dt)
    if not self.isStarted then
        self.isStarted = true
        self.level:start()
    end

    self.level:update(dt)
end

function PlayState:render()
    self.level:render()
end
