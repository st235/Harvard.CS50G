LeaderboardState = Class{__includes = BaseState}

function LeaderboardState:init(level, isWin, leaderboard, onFinish)
    self.level = level
    self.isWin = isWin
    self.leaderboard = leaderboard
    self.onFinish = onFinish
end

function LeaderboardState:enter()
    local leaderboardWidth = 200
    local leaderboardHeight = 120
    local leaderboardSpacing = 10
    local levelLabelWidth = leaderboardWidth
    local levelLabelHeight = 40
    local levelLabelMargin = 10
    local detailLabelWidth = 200
    local detailLabelHeight = 10
    local overallViewsHeight = leaderboardHeight + levelLabelHeight + levelLabelMargin + detailLabelHeight + leaderboardSpacing

    local verticalOffset = math.floor((VIRTUAL_HEIGHT - overallViewsHeight) / 2)

    self.levelLabel = Label(math.floor((VIRTUAL_WIDTH - levelLabelWidth)/ 2), verticalOffset,
        levelLabelWidth, levelLabelHeight,
        'Level ' .. tostring(self.level) .. '\nLeaderbord', gFonts['medium'],
        { 0, 0, 0 }, 'center', 'center')
    self.levelLabel:setBackground(Rectangle({ 255, 255, 255 }))

    self.leaderboardView = Leaderboard(math.floor((VIRTUAL_WIDTH - leaderboardWidth)/ 2), verticalOffset + levelLabelHeight + levelLabelMargin,
        leaderboardWidth, leaderboardHeight,
        gFonts['small'], self.leaderboard)

    self.detailLabel = Label(math.floor((VIRTUAL_WIDTH - detailLabelWidth)/ 2), verticalOffset + levelLabelHeight + levelLabelMargin + leaderboardHeight + leaderboardSpacing,
        detailLabelWidth, detailLabelHeight,
        "Press 'Enter' to continue", gFonts['small'],
        { 169, 169, 169 }, 'center', 'center')
    self.detailLabel.alpha = 0

    Timer.every(1, function()
        if self.detailLabel.alpha == 0 then
            self.detailLabel.alpha = 255
        else
            self.detailLabel.alpha = 0
        end
    end)
end

function LeaderboardState:update(dt)
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gSounds['confirm']:stop()
        gSounds['confirm']:play()

        gStateStack:push(FadeInState({ 0, 0, 0 }, 1, function()
            -- pop fade in state
            gStateStack:pop()

            -- pop leaderboard state
            gStateStack:pop()
        
            if self.isWin then
                local nextLevel = self.level + 1
    
                if self:checkLevelExists(nextLevel) then
                    gStateStack:push(BeginLevelState(nextLevel))
                else
                    gStateStack:push(CreditsState())
                    gStateStack:push(FadeOutState({ 0, 0, 0 }, 0, 2, function()
                        -- pop fade out state
                        gStateStack:pop()
                    end))
                end
            else
                gStateStack:push(StartState())
            end
        end))
    end
end

function LeaderboardState:checkLevelExists(levelId)
    return (not not LEVELS[levelId])
end

function LeaderboardState:render()
    love.graphics.clear(0, 0, 0, 1)
 
    self.levelLabel:render()
    self.leaderboardView:render()
    self.detailLabel:render()
end
