Vehicle = Class{}

function Vehicle:init(x, y, width, height, driverId, driverName, speed, texture, frames, color)
    self.x = x
    self.y = y
    self.rotation = 0
    self.width = width
    self.height = height
    self.driverId = driverId
    self.driverName = driverName
    -- symbols per second
    self.speed = speed

    self.color = color or { 210, 105, 30 }
    assert(#self.color == 3)

    self.animation = Animation {
        frames = frames,
        interval = 0.2,
        texture = texture,
        looping = true,
    }
end

function Vehicle:update(dt)
    self.animation:update(dt)
end

function Vehicle:render()
    local anim = self.animation

    love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255, 1)
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.x), math.floor(self.y), self.rotation)

    love.graphics.setColor(1, 1, 1, 1)
end

