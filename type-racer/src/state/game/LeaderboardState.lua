LeaderboardState = Class{__includes = BaseState}

function LeaderboardState:init(level, leaderboard, onFinish)
    self.level = level
    self.leaderboard = leaderboard
    self.onFinish = onFinish
end

function LeaderboardState:enter()
    local leaderboardWidth = 200
    local leaderboardHeight = 120
    local levelLabelWidth = leaderboardWidth
    local levelLabelHeight = 40
    local levelLabelMargin = 10
    local overallViewsHeight = leaderboardHeight + levelLabelHeight + levelLabelMargin

    local verticalOffset = math.floor((VIRTUAL_HEIGHT - overallViewsHeight) / 2)

    self.levelLabel = Label(math.floor((VIRTUAL_WIDTH - levelLabelWidth)/ 2), verticalOffset,
        levelLabelWidth, levelLabelHeight,
        'Level ' .. tostring(self.level) .. '\nLeaderbord', gFonts['medium'],
        { 0, 0, 0 }, 'center', 'center')
    self.levelLabel:setBackground(Rectangle({ 255, 255, 255 }))


    self.leaderboard = Leaderboard(math.floor((VIRTUAL_WIDTH - leaderboardWidth)/ 2), verticalOffset + levelLabelHeight + levelLabelMargin,
        leaderboardWidth, leaderboardHeight,
        gFonts['small'], self.leaderboard)
end

function LeaderboardState:render()
    love.graphics.clear(0, 0, 0, 1)
 
    self.levelLabel:render()
    self.leaderboard:render()
end
