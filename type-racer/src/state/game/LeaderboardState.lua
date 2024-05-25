LeaderboardState = Class{__includes = BaseState}

function LeaderboardState:init(level, leaderboardInfo, onFinish)
    self.level = level
    self.leaderboardInfo = leaderboardInfo
    self.onFinish = onFinish
end

function LeaderboardState:enter()
    self.leaderboard = Leaderboard(0, 0, 100, 100, gFonts['small'], self.level, 100)
end

function LeaderboardState:render()
    self.leaderboard:render()
end
