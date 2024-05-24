StatsView = Class{__includes=View}

function StatsView:init(x, y, width, height,
                          titleFont,
                          smallFont, mediumFont,
                          level, trophySkin, 
                          paddingTop, paddingLeft,
                          paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.smallFont = smallFont
    self.mediumFont = mediumFont
    self.trophySkin = trophySkin

    self.levelLabel = Label(self.x + self.paddingLeft, self.y + self.paddingTop, 
        self:getAdjustedWidth(), 12, 
        'Level: ' .. tostring(level),
        titleFont, { 255, 255, 255 },
        'left', 'center')

    self:setSpeed(0)
    self:setPosition(nil)
end

function StatsView:setSpeed(speed)
    local offsetY = self.levelLabel.height + self.paddingTop

    self.speedLabel = Label(self.x + self.paddingLeft, self.y + offsetY,
        self:getAdjustedWidth() / 2, 28, 
        tostring(speed), self.mediumFont,
        { 255, 255, 255 }, 'center', 'center')

    self.speedUnitsLabel = Label(self.x + self.paddingLeft, self.y + offsetY + self.speedLabel.height,
    self:getAdjustedWidth() / 2, 28, 
    "symbols per\nminute", self.smallFont,
    { 255, 255, 255 }, 'center', 'center')
end

function StatsView:setPosition(position)
    if (position or 0) < 1 or (position or 0) > 4 then
        position = 0
    end

    local placeText = PLACES_NAMES[position] 

    local centerX = self:getCenterX()
    local offsetY = self.levelLabel.height + self.paddingTop

    local frame = (4 - position) * 3 + self.trophySkin
    if position == 0 then
        frame = self.trophySkin
    end

    self.trophyIcon = Icon(centerX, self.y + offsetY,
        self:getAdjustedWidth() / 2, 28, 'trophies', frame)
    self.trophyIcon:setBackground(Circle({255, 255, 255}))

    self.trophyTextLabel = Label(centerX, self.y + offsetY + self.trophyIcon.height,
        self:getAdjustedWidth() / 2, 28, 
        placeText, self.smallFont,
        { 255, 255, 255 }, 'center', 'center')
end

function StatsView:update(dt)
end

function StatsView:render()
    View.render(self)

    self.levelLabel:render()
    self.speedLabel:render()
    self.speedUnitsLabel:render()
    self.trophyIcon:render()
    self.trophyTextLabel:render()
end
