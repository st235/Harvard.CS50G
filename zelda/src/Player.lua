--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:heal()
    self.health = math.min(6, self.health + 2)
end

function Player:getHeadPoint()
    return { math.floor(self.x + self.width / 2), math.floor(self.y + 5) }
end

function Player:getCenterPoint()
    return { math.floor(self.x + self.width / 2), math.floor(self.y + self.height / 2) }
end

function Player:collides(target)
    local selfY, selfHeight = self.y + self.height / 2, self.height - self.height / 2
    
    return not (self.x + self.width < target.x or self.x > target.x + target.width or
                selfY + selfHeight < target.y or selfY > target.y + target.height)
end

function Player:render()
    Entity.render(self)
    
    -- love.graphics.setColor(255, 0, 0, 255)
    -- local point = self:getHeadPoint()
    -- love.graphics.points(point[1], point[2])
    -- love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end