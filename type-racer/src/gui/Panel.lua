Panel = Class{}

function Panel:init(x, y, width, height, foregroundColor, borderColor, thickness, rx, ry)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.isVisible = true

    self.foregroundColor = foregroundColor or { 15, 56, 15 }
    self.borderColor = borderColor or { 242, 253, 227 }
    assert(#self.foregroundColor == 3)
    assert(#self.borderColor == 3)

    self.thickness = thickness or 2

    self.rx = rx or 4
    self.ry = ry or 4
end

function Panel:setVisibility(isVisible)
    self.isVisible = isVisible
end

function Panel:isVisible()
    return self.isVisible
end

function Panel:update(dt)
end

function Panel:render()
    love.graphics.setColor(self.foregroundColor[1] / 255, self.foregroundColor[2] / 255, self.foregroundColor[3] / 255, 1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height, self.rx, self.ry)
    love.graphics.setColor(self.borderColor[1] / 255, self.borderColor[2] / 255, self.borderColor[3] / 255, 1)
    love.graphics.rectangle('fill', self.x + self.thickness, self.y + self.thickness, self.width - 2 * self.thickness, self.height - 2 * self.thickness, self.rx, self.ry)
    love.graphics.setColor(self.foregroundColor[1] / 255, self.foregroundColor[2] / 255, self.foregroundColor[3] / 255, 1)
    love.graphics.rectangle('fill', self.x + 2 * self.thickness, self.y + 2 * self.thickness, self.width - 4 * self.thickness, self.height - 4 * self.thickness, self.rx, self.ry)

    -- reset color back to normal
    love.graphics.setColor(1, 1, 1, 1)
end
