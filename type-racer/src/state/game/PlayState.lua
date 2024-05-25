PlayState = Class{__includes = BaseState}

function PlayState:init(levelId, levelDef)
    self.levelId = levelId
    self.levelDef = levelDef
end

function PlayState:enter()
    self.level = Level(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, self.levelId, self.levelDef)

    self.level.onWin = function(isBossFight)
        local leaderboard = self.level:getLeaderboard()

        gStateStack:push(VictoryState('Victory!!1!', { 255, 255, 255 }, 6, function()
            gStateStack:push(FadeInState({0, 0, 0}, 1, function()
                -- pop fade in state
                gStateStack:pop()
                -- pop victory state
                gStateStack:pop()
                -- pop play state
                gStateStack:pop()

                gStateStack:push(LeaderboardState(self.levelId, true, leaderboard))
            end))
        end))
    end

    self.level.onLose = function(reason, isBossFight, coords)
        local leaderboard = self.level:getLeaderboard()

        local message = ""
        if reason == LEVEL_LOST_REASON_KILLED then
            description = GAME_OVER_OPPONENTS_KILLED_MESSAGES[math.random(#GAME_OVER_OPPONENTS_KILLED_MESSAGES)]
        elseif reason == LEVEL_LOST_REASON_TYPOS then
            description = GAME_OVER_TOO_MANY_TYPOS[math.random(#GAME_OVER_TOO_MANY_TYPOS)]
        end

        local playerX, playerY = coords[1], coords[2]
        gStateStack:push(GameOverState("Game Over...", description, playerX, playerY, 20, 4,
        function()
            gStateStack:push(FadeInState({0, 0, 0}, 1, function()
                -- pop fade in state
                gStateStack:pop()
                -- pop victory state
                gStateStack:pop()
                -- pop play state
                gStateStack:pop()

                gStateStack:push(LeaderboardState(self.levelId, false, leaderboard))
            end))
        end))
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
