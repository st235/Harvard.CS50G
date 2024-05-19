--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

GameObject = Class{}

function GameObject:init(def, x, y)
    
    -- string identifying this object type
    self.type = def.type

    self.texture = def.texture

    if def.frames then
        self.frame = def.frames[math.random(1, #def.frames)]
    else
        self.frame = def.frame or 1
    end

    -- whether it acts as an obstacle or not
    self.solid = def.solid

    self.defaultState = def.defaultState
    self.state = self.defaultState
    self.states = def.states

    self.renderOnTop = false

    -- dimensions
    self.dx = 0
    self.dy = 0
    self.x = x
    self.y = y
    self.width = def.width
    self.height = def.height
    self.scaleX = def.scaleX or 1
    self.scaleY = def.scaleY or 1

    self.destroyed = false

    -- default empty collision callback
    self.collidiable = true
    self.onCollide = function(entity) end

    self.onUpdated = function() end
end

function GameObject:throw(direction)
    local dx, dy = 0, 0

    if direction == 'left' then
        dx = -GAME_OBJECT_PROJECTION_SPEED
    elseif direction == 'right' then
        dx = GAME_OBJECT_PROJECTION_SPEED
    elseif direction == 'up' then
        dy = -GAME_OBJECT_PROJECTION_SPEED
    elseif direction == 'down' then
        dy = GAME_OBJECT_PROJECTION_SPEED
    end

    self.beginThrowX = self.x
    self.beginThrowY = self.y

    self.dx = dx
    self.dy = dy
end

function GameObject:update(dt)
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt 

    self.onUpdated()
end

function GameObject:render(adjacentOffsetX, adjacentOffsetY)
    local frame = self.frame
    if self.state and self.states then
        frame = self.states[self.state].frame or self.frame
    end

    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][frame],
        self.x + adjacentOffsetX, self.y + adjacentOffsetY, 0, self.scaleX, self.scaleY)
end