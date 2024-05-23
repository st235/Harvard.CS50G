Circle = Class{}

function Circle:init(color, radius)
    assert(#color == 3)

    self.color = color
    self.radius = radius
end

function Circle:draw(x, y, width, height)
    local realRadius = self.radius or math.floor(math.min(width, height) / 2)

    love.graphics.setColor(self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 1)
    love.graphics.circle('fill', math.floor(x + width / 2), math.floor(y + height / 2), realRadius)

    love.graphics.setColor(1, 1, 1, 1)
end
