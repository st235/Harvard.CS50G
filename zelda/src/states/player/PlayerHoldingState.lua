PlayerHoldingState = Class{__includes = BaseState}

function PlayerHoldingState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- lift-left, lift-up, etc
    self.player:changeAnimation('lift-' .. self.player.direction)
end

function PlayerHoldingState:enter(params)
    self.pot = params.pot

    -- restart lift animation
    self.player.currentAnimation:refresh()
end

function PlayerHoldingState:update(dt)
    
end

function PlayerHoldingState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
end

