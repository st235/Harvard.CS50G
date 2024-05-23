Panel = Class{}

function Panel:init(foregroundColor, borderColor, thickness, rx, ry)
    self.foregroundColor = foregroundColor or { 15, 56, 15 }
    self.borderColor = borderColor or { 242, 253, 227 }
    assert(#self.foregroundColor == 3)
    assert(#self.borderColor == 3)

    self.thickness = thickness or 2

    self.rx = rx or 4
    self.ry = ry or 4
end

function Panel:render(x, y, width, height)
    love.graphics.setColor(self.foregroundColor[1] / 255, self.foregroundColor[2] / 255, self.foregroundColor[3] / 255, 1)
    love.graphics.rectangle('fill', x, y, width, height, self.rx, self.ry)
    love.graphics.setColor(self.borderColor[1] / 255, self.borderColor[2] / 255, self.borderColor[3] / 255, 1)
    love.graphics.rectangle('fill', x + self.thickness, y + self.thickness, width - 2 * self.thickness, height - 2 * self.thickness, self.rx, self.ry)
    love.graphics.setColor(self.foregroundColor[1] / 255, self.foregroundColor[2] / 255, self.foregroundColor[3] / 255, 1)
    love.graphics.rectangle('fill', x + 2 * self.thickness, y + 2 * self.thickness, width - 4 * self.thickness, height - 4 * self.thickness, self.rx, self.ry)

    -- reset color back to normal
    love.graphics.setColor(1, 1, 1, 1)
end
