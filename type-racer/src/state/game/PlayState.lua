PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter()
    self.level = Level(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, 1)

    self.level.onWin = function(isBossFight)
        gStateStack:push(VictoryState('Victory!!1!'))
    end

    self.level.onLose = function(reason, isBossFight, coords)
        local message = ""
        if reason == LEVEL_LOST_REASON_KILLED then
            description = GAME_OVER_OPPONENTS_KILLED_MESSAGES[math.random(#GAME_OVER_OPPONENTS_KILLED_MESSAGES)]
        elseif reason == LEVEL_LOST_REASON_TYPOS then
            description = GAME_OVER_TOO_MANY_TYPOS[math.random(#GAME_OVER_TOO_MANY_TYPOS)]
        end

        local playerX, playerY = coords[1], coords[2]
        gStateStack:push(GameOverState("Game Over...", description, playerX, playerY, 20))
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
