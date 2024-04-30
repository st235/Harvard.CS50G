Powerup = Class{}

-- Powerups with 5% chance.
local POWERUP_RANDOM_CHANCE = 100

local POWERUP_VERTICAL_SPEED = 20

Powerup.SKIN_EXTRA_BALL = 9

function Powerup.shouldSpawnExtraBallPowerup(ballsCount)
    if ballsCount ~= 1 then
        return false
    end

    return math.random(0, 100) < POWERUP_RANDOM_CHANCE
end

function Powerup:init(x, y)
    self.skin = Powerup.SKIN_EXTRA_BALL

    self.width = 16
    self.height = 16

    -- we need to center power up to place it
    -- into initial x and y position.
    self.x = x - self.width / 2
    self.y = y - self.height / 2

    self.dy = POWERUP_VERTICAL_SPEED

    self.isDead = false
end

function Powerup:collides(target)
    local ltx = math.max(target.x, self.x)
    local lty = math.max(target.y, self.y)
    local rbx = math.min(target.x + target.width, self.x + self.width)
    local rby = math.min(target.y + target.height, self.y + self.height)
    return ltx < rbx and lty < rby
end

function Powerup:update(dt)
    self.y = self.y + self.dy * dt

    if self.y >= VIRTUAL_HEIGHT then
        self.isDead = true
    end
end

function Powerup:render()
    love.graphics.draw(gTextures['main'], gFrames['powerups'][self.skin], self.x, self.y)
end
