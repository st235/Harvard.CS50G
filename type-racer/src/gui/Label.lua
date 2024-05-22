Label = Class{}

function Label:init(x, y, width, height, 
                    text, font, 
                    textColor, textGravity,
                    paddingTop, paddingLeft,
                    paddingBottom, paddingRight)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.paddingTop = paddingTop or 0
    self.paddingLeft = paddingLeft or 0
    self.paddingBottom = paddingBottom or 0
    self.paddingRight = paddingRight or 0

    local _, wrappedText = font:getWrap(text, self.width - self.paddingLeft - self.paddingRight)

    self.textChunks = wrappedText
    self.textColor = textColor or { 255, 255, 255 }
    self.textGravity = textGravity or 'left'
    self.font = font

    assert(#self.textColor == 3)
end

function Label:update()
end

function Label:render()
    local currentX = self.x + self.paddingLeft
    local currentY = self.y + self.paddingTop

    local textHeight = self.font:getHeight()
    local adjustedWidth = self.width - self.paddingLeft - self.paddingRight

    love.graphics.setColor(self.textColor[1] / 255, self.textColor[2] / 255, self.textColor[3] / 255, 1)

    for _, text in ipairs(self.textChunks) do
        love.graphics.printf(text, self.font, currentX, currentY, adjustedWidth, self.textGravity)
        
        currentY = currentY + textHeight
    end

    love.graphics.setColor(1, 1, 1, 1)
end
