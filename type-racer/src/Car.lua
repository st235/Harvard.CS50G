Car = Class{}

function Car:init(x, y, width, height, frames, color)
    self.x = x
    self.y = y
    self.color = color or { 210, 105, 30 }
    assert(#self.color == 3)

    self.animation = Animation {
        frames = frames,
        interval = 0.2,
        texture = 'vehicles',
        looping = true,
    }
end

function Car:update(dt)
    self.x = self.x + -12 * dt

    self.animation:update(dt)
end

function Car:render()
    local anim = self.animation

    love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255, 1)
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.x), math.floor(self.y))

    love.graphics.setColor(1, 1, 1, 1)
end

