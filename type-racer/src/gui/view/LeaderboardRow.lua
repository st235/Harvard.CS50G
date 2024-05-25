LeaderboardRow = Class{__includes=View}

function LeaderboardRow:init(x, y, width, height,
                          font,
                          driverId, driverName, driverSpeed,
                          place, timing,
                          paddingTop, paddingLeft,
                          paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.font = font

    self.driverId = driverId
    self.driverName = driverName
    self.driverSpeed = driverSpeed
    self.place = place
    self.timing = timing

    local iconWidth = 16
    local iconHeight = 16
    local iconMargin = 4
    local plateWidth = 20
    local plateMargin = 4
    local speedLabelWidth = 60
    local speedLabelMargin = 10
    local centerMargin = 2

    if self.place then
        self.trophyIcon = self:createTrophyIcon(iconWidth, iconHeight)
    end
    self.driverPlateLabel = self:createPlateLabel(iconWidth, iconMargin, plateWidth, centerMargin)
    self.driverNameLabel = self:createNameLabel(iconWidth, iconMargin, plateWidth, plateMargin, centerMargin)
    self.driverSpeedLabel = self:createSpeedLabel(iconWidth, iconMargin, speedLabelWidth, centerMargin)
    if self.timing then
        self.timingLabel = self:createTimingLabel(iconWidth, iconMargin, speedLabelWidth, speedLabelMargin, centerMargin)
    end
end

function LeaderboardRow:createTrophyIcon(iconWidth, iconHeight)
    local trophySkin = math.random(1, 3)
    local trophyFrame = (4 - self.place) * 3 + trophySkin 

    return Icon(self.x + self.paddingLeft, self.y + self.paddingTop + math.floor((self.height - iconHeight) / 2),
        iconWidth, iconHeight, 'trophies', trophyFrame)
end

function LeaderboardRow:createPlateLabel(iconWidth, iconMargin, plateWidth, centerMargin)
    local centerY = self:getCenterY()
    local textHeight = self.font:getHeight()

    local label = Label(self.x + self.paddingLeft + iconWidth + iconMargin, centerY - textHeight - centerMargin,
        plateWidth, textHeight,
        "#" .. tostring(self.driverId), self.font, { 0, 0, 0 }, 'center', 'center')
    label:setBackground(Rectangle({ 255, 255, 255 }, 2, 2))
    return label
end

function LeaderboardRow:createNameLabel(iconWidth, iconMargin, plateWidth, plateMargin, centerMargin)
    local centerY = self:getCenterY()
    local textHeight = self.font:getHeight()

    return Label(self.x + self.paddingLeft + iconWidth + iconMargin + plateWidth + plateMargin, centerY - textHeight - centerMargin, 
        self:getAdjustedWidth() - iconWidth - iconMargin, math.floor(self:getAdjustedHeight() / 2),
        self.driverName, self.font)
end

function LeaderboardRow:createSpeedLabel(iconWidth, iconMargin, speedLabelWidth, centerMargin)
    local centerY = self:getCenterY()

    local label = Label(self.x + self.paddingLeft + iconWidth + iconMargin, centerY + centerMargin, 
        speedLabelWidth, math.floor(self:getAdjustedHeight() / 2),
        tostring(self.driverSpeed) .. " spm", self.font, { 211, 211, 211 }, 'left')
    return label
end

function LeaderboardRow:createTimingLabel(iconWidth, iconMargin, speedLabelWidth, speedLabelMargin, centerMargin)
    local centerY = self:getCenterY()

    local offsetX = iconWidth + speedLabelWidth + iconMargin + speedLabelMargin

    local label = Label(self.x + self.paddingLeft + offsetX, centerY + centerMargin,
        self:getAdjustedWidth() - offsetX, math.floor(self:getAdjustedHeight() / 2),
        tostring(self.timing) .. " sec.", self.font, { 255, 255, 255 }, 'right')
    return label
end

function LeaderboardRow:update(dt)
end

function LeaderboardRow:render()
    View.render(self)

    if self.place then
        self.trophyIcon:render()
    end
    self.driverPlateLabel:render()
    self.driverNameLabel:render()
    self.driverSpeedLabel:render()
    if self.timing then
        self.timingLabel:render()
    end
end
