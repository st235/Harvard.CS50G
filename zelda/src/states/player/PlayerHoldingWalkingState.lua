PlayerHoldingWalkingState = Class{__includes = BaseState}

function PlayerHoldingWalkingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon
end

function PlayerHoldingWalkingState:enter(params)
    self.pot = params.pot
    self.pot.solid = false
    self.pot.renderOnTop = true
end

function PlayerHoldingWalkingState:update(dt)
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player:changeAnimation('hold-walk-left')
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player:changeAnimation('hold-walk-right')
    elseif love.keyboard.isDown('up') then
        self.player.direction = 'up'
        self.player:changeAnimation('hold-walk-up')
    elseif love.keyboard.isDown('down') then
        self.player.direction = 'down'
        self.player:changeAnimation('hold-walk-down')
    else
        self.player:changeState('hold-idle', {
            ['pot'] = self.pot
        })
    end

    -- perform base collision detection against walls
    updateEntityWithinRoom(dt, self.player, self.dungeon.currentRoom.objects)

    local playerHeadPoint = self.player:getHeadPoint()
    self.pot.x = playerHeadPoint[1] - math.floor(self.pot.width / 2)
    self.pot.y = playerHeadPoint[2] - math.floor(self.pot.height)
end

function PlayerHoldingWalkingState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end
