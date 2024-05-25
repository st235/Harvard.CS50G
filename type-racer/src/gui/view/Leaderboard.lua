Leaderboard = Class{__includes=View}

function Leaderboard:init(x, y, width, height,
                          font,
                          leaderboard,
                          paddingTop, paddingLeft,
                          paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.font = font

    self.rowMargin = 8
    self.rowHeight = 20

    self.verticalOffset = math.floor(self:getAdjustedHeight() - self.rowHeight * #leaderboard - self.rowMargin * (#leaderboard - 1)) / 2

    self.resultRows = {}
    for i=1, #leaderboard do
        local info = leaderboard[i]

        local driverId = info.driverId
        local driverName = info.driverName
        local driverSpeed = info.driverSpeed
        local place = info.place
        local timing = info.timing

        self:addDriverResults(i - 1, driverId, driverName, driverSpeed, place, timing)
    end
end

function Leaderboard:addDriverResults(i, driverId, driverName, driverSpeed, place, timing)
    local rowOffset = self.rowHeight * i + self.rowMargin * i

    local row = LeaderboardRow(self.x + self.paddingLeft, self.y + self.paddingTop + self.verticalOffset + rowOffset, 
        self:getAdjustedWidth(), self.rowHeight, self.font, 
        driverId, driverName, driverSpeed, place, timing)

    table.insert(self.resultRows, row)
end

function Leaderboard:update(dt)
end

function Leaderboard:render()
    View.render(self)

    for i=1, #self.resultRows do
        self.resultRows[i]:render()
    end
end
