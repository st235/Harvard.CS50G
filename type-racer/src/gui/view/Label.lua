Label = Class{__includes = View}

function Label:init(x, y, width, height,
                    text, font,
                    color, gravity, verticalAlignment,
                    paddingTop, paddingLeft,
                    paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.color = color or { 255, 255, 255 }
    self.gravity = gravity or 'left'
    self.verticalAlignment = verticalAlignment or 'top'
    self.font = font

    assert(#self.color == 3)

    local _, wrappedText = self.font:getWrap(text, self:getAdjustedWidth())
    self.textChunks = wrappedText
end

function Label:render()
    View.render(self)

    local textHeight = self.font:getHeight()
    local adjustedWidth = self:getAdjustedWidth()

    local currentX = self.x + self.paddingLeft
    local currentY = self.y + self.paddingTop

    if self.verticalAlignment == 'center' then
        currentY = currentY + math.floor((self.height - textHeight * #self.textChunks) / 2)
    elseif self.verticalAlignment == 'bottom' then
        currentY = currentY + (self.height - textHeight * #self.textChunks)
    end

    love.graphics.setColor(self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 1)

    for _, text in ipairs(self.textChunks) do
        love.graphics.printf(text, self.font, currentX, currentY, adjustedWidth, self.gravity)
        
        currentY = currentY + textHeight
    end

    love.graphics.setColor(1, 1, 1, 1)
end
