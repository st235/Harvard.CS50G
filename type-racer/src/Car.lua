Car = Class{}

function Car:init(x, y, width, height, skin, color)

    self.x = x
    self.y = y
    self.skin = skin or 'hatchback'
    self.color = color or { 210, 105, 30 }
    assert(#self.color == 3)

    self.animation = Animation {
        frames = {1, 2},
        interval = 0.2,
        texture = 'vehicle',
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
    love.graphics.draw(gTextures['vehicles'], gFrames['car-'..self.skin][anim:getCurrentFrame()],
        math.floor(self.x), math.floor(self.y))

    love.graphics.setColor(1, 1, 1, 1)
end

