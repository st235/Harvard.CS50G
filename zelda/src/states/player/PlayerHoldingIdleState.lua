PlayerHoldingIdleState = Class{__includes = BaseState}

function PlayerHoldingIdleState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    self.player:changeAnimation('hold-idle-' .. self.player.direction)
end

function PlayerHoldingIdleState:enter(params)
    self.pot = params.pot
    self.pot.solid = false
    self.pot.renderOnTop = true

    self.player.currentAnimation:refresh()
end

function PlayerHoldingIdleState:update(dt)
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player:changeState('hold-walk', {
            ['pot'] = self.pot
        })
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player:changeState('hold-walk', {
            ['pot'] = self.pot
        })
    elseif love.keyboard.isDown('up') then
        self.player.direction = 'up'
        self.player:changeState('hold-walk', {
            ['pot'] = self.pot
        })
    elseif love.keyboard.isDown('down') then
        self.player.direction = 'down'
        self.player:changeState('hold-walk', {
            ['pot'] = self.pot
        })
    end

    local playerHeadPoint = self.player:getHeadPoint()
    self.pot.x = playerHeadPoint[1] - math.floor(self.pot.width / 2)
    self.pot.y = playerHeadPoint[2] - math.floor(self.pot.height)
end

function PlayerHoldingIdleState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end
