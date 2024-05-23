Label = Class{__includes = View}

function Label:init(x, y, width, height, 
                    text, font, 
                    textColor, textGravity,
                    paddingTop, paddingLeft,
                    paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.textColor = textColor or { 255, 255, 255 }
    self.textGravity = textGravity or 'left'
    self.font = font

    assert(#self.textColor == 3)

    local _, wrappedText = font:getWrap(text, self:getAdjustedWidth())
    self.textChunks = wrappedText
end

function Label:render()
    View.render(self)

    local currentX = self.x + self.paddingLeft
    local currentY = self.y + self.paddingTop

    local textHeight = self.font:getHeight()
    local adjustedWidth = self:getAdjustedWidth()

    love.graphics.setColor(self.textColor[1] / 255, self.textColor[2] / 255, self.textColor[3] / 255, 1)

    for _, text in ipairs(self.textChunks) do
        love.graphics.printf(text, self.font, currentX, currentY, adjustedWidth, self.textGravity)
        
        currentY = currentY + textHeight
    end

    love.graphics.setColor(1, 1, 1, 1)
end
