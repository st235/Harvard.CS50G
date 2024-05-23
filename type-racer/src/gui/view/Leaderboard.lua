Leaderboard = Class{__includes=View}

function Leaderboard:init(x, y, width, height,
                          font,
                          level, speed,
                          paddingTop, paddingLeft,
                          paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.font = font

    local labelOffsetX = 6
    local labelOffsetY = 2
    self.levelLabel = Label(self.x + labelOffsetX, self.y + labelOffsetY, 60, 14, 'Level: ' .. tostring(level), self.font)

    self:setSpeed(0)
end

function Leaderboard:setSpeed(newSpeed)
    self.speed = newSpeed

    self.speedLabel = Label(self.x + 6, self.y + self.levelLabel.height + 2, 60, 14, 'Speed: ' .. tostring(self.speed) .. ' cps.', self.font)
end

function Leaderboard:update(dt)
end

function Leaderboard:render()
    View.render(self)

    self.levelLabel:render()
    self.speedLabel:render()
end
