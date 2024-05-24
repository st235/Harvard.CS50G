LeaderboardRow = Class{__includes=View}

function LeaderboardRow:init(x, y, width, height,
                          font,
                          driverId, driverName, place, timing,
                          paddingTop, paddingLeft,
                          paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.font = font

    self.driverId = driverId
    self.driverName = driverName
    self.place = place
    self.timing = timing

    local iconMargin = 4

    self.trophyIcon = self:createTrophyIcon()
    self.driverNameLabel = self:createNameLabel(self.trophyIcon.width, iconMargin)
    self.driverPlateLabel = self:createPlateLabel(self.trophyIcon.width, iconMargin)
    self.timingLabel = self:createTimingLabel(self.trophyIcon.width, iconMargin, self.driverPlateLabel.width, 2)
end

function LeaderboardRow:createTrophyIcon()
    local iconWidth = 16
    local iconHeight = 16
    local trophySkin = math.random(1, 3)
    local trophyFrame = (4 - self.place) * 3 + trophySkin 

    return Icon(self.x + self.paddingLeft, self.y + math.floor((self.height - iconHeight) / 2),
        iconWidth, iconHeight, 'trophies', trophyFrame)
end

function LeaderboardRow:createNameLabel(iconWidth, iconMargin)
    local centerY = self:getCenterY()
    local textHeight = self.font:getHeight()

    return Label(self.x + self.paddingLeft + iconWidth + iconMargin, centerY - textHeight, 
        self:getAdjustedWidth() - iconWidth - iconMargin, math.floor(self:getAdjustedHeight() / 2),
        self.driverName, self.font)
end

function LeaderboardRow:createPlateLabel(iconWidth, iconMargin)
    local centerY = self:getCenterY()
    local textHeight = self.font:getHeight()

    local label = Label(self.x + self.paddingLeft + iconWidth + iconMargin, centerY, 
        20, math.floor(self:getAdjustedHeight() / 2),
        "#" .. tostring(self.driverId), self.font, { 255, 255, 255 }, 'left')
    return label
end

function LeaderboardRow:createTimingLabel(iconWidth, iconMargin, plateWidth, plateMargin)
    local centerY = self:getCenterY()
    local textHeight = self.font:getHeight()

    local offsetX = iconWidth + plateWidth + iconMargin + plateMargin

    local label = Label(self.x + self.paddingLeft + offsetX, centerY, 
        self:getAdjustedWidth() - offsetX, math.floor(self:getAdjustedHeight() / 2),
        tostring(self.timing) .. " sec.", self.font, { 255, 255, 255 }, 'right')
    return label
end

function LeaderboardRow:update(dt)
end

function LeaderboardRow:render()
    View.render(self)

    self.trophyIcon:render()
    self.driverNameLabel:render()
    self.driverPlateLabel:render()
    self.timingLabel:render()
end
