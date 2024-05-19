--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerIdleState = Class{__includes = BaseState}

function PlayerIdleState:init(player, dungeon)
    self.player = player
    self.player:changeAnimation('idle-' .. self.player.direction)
    self.dungeon = dungeon
end

function PlayerIdleState:enter(params)
    
    -- render offset for spaced character sprite (negated in render function of state)
    self.player.offsetY = 5
    self.player.offsetX = 0
end

function PlayerIdleState:update(dt)
    if love.keyboard.isDown('left') or love.keyboard.isDown('right') or
       love.keyboard.isDown('up') or love.keyboard.isDown('down') then
        self.player:changeState('walk')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('swing-sword')
    end

    if love.keyboard.wasPressed('return') then
        local pot = self:findNearestPotInLookingDirection()

        if pot ~= nil then
            self.player:changeState('lift', {
                ['pot'] = pot
            }) 
        end
    end
end

function PlayerIdleState:findNearestPotInLookingDirection()
    local playerCenterPoint = self.player:getCenterPoint()
    local playerX = playerCenterPoint[1]
    local playerY = playerCenterPoint[2]

    local pot = nil

    for k, object in pairs(self.dungeon.currentRoom.objects) do
        if object.type ~= 'pot' then
            goto continue
        end

        local potX = math.floor(object.x + object.width / 2)
        local potY = math.floor(object.y + object.height / 2)

        local dx, dy = potX - playerX, potY - playerY
        local distance = (dx ^ 2 + dy ^ 2) ^ 0.5

        local canPickup = distance <= POT_PICKUP_DISTANCE
        if not canPickup then
            goto continue
        end

        if self.player.direction == 'left' and dx < 0 and math.abs(dy) <= POT_LOOK_SIGHT then
            pot = object
        elseif self.player.direction == 'up' and dy < 0 and math.abs(dx) <= POT_LOOK_SIGHT then
            pot = object
        elseif self.player.direction == 'right' and dx > 0 and math.abs(dy) <= POT_LOOK_SIGHT then
            pot = object
        elseif self.player.direction == 'down' and dy > 0 and math.abs(dx) <= POT_LOOK_SIGHT then
            pot = object
        end
        
        ::continue::
    end

    return pot
end

function PlayerIdleState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end
