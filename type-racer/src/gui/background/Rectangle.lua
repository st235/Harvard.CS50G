Rectangle = Class{}

function Rectangle:init(color, rx, ry)
    self.color = color or { 15, 56, 15 }
    assert(#self.color == 3)

    self.rx = rx or 0
    self.ry = ry or 0
end

function Rectangle:draw(x, y, width, height)
    love.graphics.setColor(self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 1)
    love.graphics.rectangle('fill', x, y, width, height, self.rx, self.ry)

    -- reset color back to normal
    love.graphics.setColor(1, 1, 1, 1)
end
