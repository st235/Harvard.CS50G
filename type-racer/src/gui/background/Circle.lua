Circle = Class{}

function Circle:init(color, style, radius)
    assert(#color == 3)

    self.color = color
    self.style = style or 'fill'
    self.radius = radius
end

function Circle:draw(x, y, width, height)
    local realRadius = self.radius or math.floor(math.min(width, height) / 2)

    love.graphics.setColor(self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 1)

    if self.style == 'line' then
        love.graphics.setLineWidth(2)
        love.graphics.setLineStyle('rough')
    end

    love.graphics.circle(self.style, math.floor(x + width / 2), math.floor(y + height / 2), realRadius)

    love.graphics.setColor(1, 1, 1, 1)
end
