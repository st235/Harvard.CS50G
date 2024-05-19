PlayerLiftingState = Class{__includes = BaseState}

function PlayerLiftingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- lift-left, lift-up, etc
    self.player:changeAnimation('lift-' .. self.player.direction)
end

function PlayerLiftingState:enter(params)
    self.pot = params.pot
    self.pot.solid = false
    self.pot.renderOnTop = true

    self.player.currentAnimation:refresh()
end

function PlayerLiftingState:update(dt)
    if self.player.currentAnimation.isFinished then
        local playerHeadPoint = self.player:getHeadPoint()

        self.pot.x = playerHeadPoint[1] - math.floor(self.pot.width / 2)
        self.pot.y = playerHeadPoint[2] - math.floor(self.pot.height)

        self.player:changeState('hold-idle', {
            ['pot'] = self.pot
        })
    end
end

function PlayerLiftingState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end

