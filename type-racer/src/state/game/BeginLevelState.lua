BeginLevelState = Class{__includes = BaseState}

function BeginLevelState:init(levelId, onFinish)
    self.levelId = levelId

    local allLevelDefs = LEVELS[levelId]
    self.levelDef = allLevelDefs[math.random(#allLevelDefs)]

    self.onFinish = onFinish
end

function BeginLevelState:getOpponents()
    local opponentIds = self.levelDef.opponents

    local opponents = {}
    for i=1,#opponentIds do
        local id = opponentIds[i]
        local opponent = OPPONENTS[id]

        table.insert(opponents, {
            ['driverId'] = opponent.driverId,
            ['driverName'] = opponent.name,
            ['driverSpeed'] = opponent.speed,
        })
    end

    return opponents
end

function BeginLevelState:enter()
    local opponents = self:getOpponents()

    local leaderboardLeftOffset = 20
    local leaderboardWidth = 200
    local leaderboardHeight = 120
    local levelLabelWidth = 100
    local levelLabelHeight = 20
    local levelLabelMargin = 10
    local overallViewsHeight = leaderboardHeight + levelLabelHeight + levelLabelMargin

    local verticalOffset = math.floor((VIRTUAL_HEIGHT - overallViewsHeight) / 2)

    self.levelLabel = Label(-levelLabelWidth, verticalOffset,
        levelLabelWidth, levelLabelHeight,
        'Level ' .. tostring(self.levelId), gFonts['medium'],
        { 0, 0, 0 }, 'left', 'center')
    self.levelLabel:setBackground(Rectangle({ 255, 255, 255 }))

    self.leaderboard = Leaderboard(leaderboardLeftOffset, verticalOffset + levelLabelHeight + levelLabelMargin,
        leaderboardWidth, leaderboardHeight,
        gFonts['small'], opponents)

    Timer.tween(1, {
        [self.levelLabel] = { x = leaderboardLeftOffset + 16 },
    }):finish(function()
        Timer.after(2, function()
            -- pop begin level state
            gStateStack:pop()

            gStateStack:push(PlayState(self.levelId, self.levelDef))

            gStateStack:push(FadeOutState({ 0, 0, 0 }, 0.45, 1, function()
                -- pop fade out
                gStateStack:pop()

                gStateStack:push(CountDownState(3, function()
                    -- pop countdown state
                    gStateStack:pop()
                end))
            end))
        end)
    end)
end

function BeginLevelState:render()
    love.graphics.clear(0, 0, 0, 1)
 
    self.levelLabel:render()
    self.leaderboard:render()
end
