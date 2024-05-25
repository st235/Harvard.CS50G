PlayState = Class{__includes = BaseState}

function PlayState:init(levelId, levelDef)
    self.levelId = levelId
    self.levelDef = levelDef
end

function PlayState:enter()
    self.level = Level(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT, self.levelId, self.levelDef)
    self:startAmbient(self.level.bossFight)

    self.level.onWin = function(isBossFight)
        local leaderboard = self.level:getLeaderboard()

        if isBossFight then
            gStateStack:push(KOState(self.level.race:getTheOnlyOpponentVehicle(), function()
                self:navigateToLeaderboard(true, leaderboard)
            end))
        else
            gStateStack:push(VictoryState('Victory!!1!', { 255, 255, 255 }, 6, function()
                self:navigateToLeaderboard(true, leaderboard)
            end))
        end
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
            self:navigateToLeaderboard(false, leaderboard)
        end))
    end

    self.isStarted = false
end

function PlayState:navigateToLeaderboard(isWin, leaderboard)
    gStateStack:push(FadeInState({0, 0, 0}, 1, function()
        -- pop fade in state
        gStateStack:pop()
        -- pop victory state
        gStateStack:pop()
        -- pop play state
        gStateStack:pop()

        gStateStack:push(LeaderboardState(self.levelId, isWin, leaderboard))
    end))
end

function PlayState:startAmbient(isBossFight)
    gSounds['engine']:stop()
    gSounds['engine']:setLooping(true)
    gSounds['engine']:setVolume(0.05)
    gSounds['engine']:play()

    self.ambientMusic = 'main'
    if isBossFight then
        if math.random(2) == 1 then
            self.ambientMusic = 'boss-fight-1'
        else
            self.ambientMusic = 'boss-fight-2'
        end
    end

    gSounds[self.ambientMusic]:stop()
    gSounds[self.ambientMusic]:setLooping(true)
    gSounds[self.ambientMusic]:setVolume(0.1)
    gSounds[self.ambientMusic]:play()
end

function PlayState:exit()
    gSounds['engine']:stop()
    gSounds[self.ambientMusic]:stop()
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
