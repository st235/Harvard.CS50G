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
    self.levelLabel = Label(self.x + labelOffsetX, self.y + labelOffsetY, self:getAdjustedWidth() - 12, 14, 'Level: ' .. tostring(level), self.font)

    self:setSpeed(0)

    self.rowsOffset = self.levelLabel.height + self.speedLabel.height + 4
    self.resultRows = {}

    self:addDriverResults(1, 'Granny', 1, 98)
    self:addDriverResults(12, 'Alex', 2, 152)
    self:addDriverResults(77, 'Ron', 3, 256)
    self:addDriverResults(13, 'Ingrid', 4, 10)
end

function Leaderboard:setSpeed(newSpeed)
    self.speed = newSpeed

    self.speedLabel = Label(self.x + 6, self.y + self.levelLabel.height + 2, self:getAdjustedWidth() - 12, 14, 'Speed: ' .. tostring(self.speed) .. ' spm.', self.font)
end

function Leaderboard:addDriverResults(driverId, driverName, place, timing)
    local row = LeaderboardRow(self.x + 6, self.y + self.rowsOffset, self:getAdjustedWidth() - 12, 20, gFonts['small'], driverId, driverName, place, timing)

    self.rowsOffset =  self.rowsOffset + row.height + 2
    table.insert(self.resultRows, row)
end

function Leaderboard:update(dt)
end

function Leaderboard:render()
    View.render(self)

    self.levelLabel:render()
    self.speedLabel:render()

    for i=1, #self.resultRows do
        self.resultRows[i]:render()
    end
end
