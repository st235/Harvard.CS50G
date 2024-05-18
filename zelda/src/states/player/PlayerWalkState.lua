--[[
    GD50
    Legend of Zelda

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PlayerWalkState = Class{__includes = BaseState}

function PlayerWalkState:init(player, dungeon)
    self.player = player
    self.dungeon = dungeon

    -- keeps track of whether we just hit a wall
    self.bumped = false

    -- render offset for spaced character sprite; negated in render function of state
    self.player.offsetY = 5
    self.player.offsetX = 0
end

function PlayerWalkState:update(dt)
    if love.keyboard.isDown('left') then
        self.player.direction = 'left'
        self.player:changeAnimation('walk-left')
    elseif love.keyboard.isDown('right') then
        self.player.direction = 'right'
        self.player:changeAnimation('walk-right')
    elseif love.keyboard.isDown('up') then
        self.player.direction = 'up'
        self.player:changeAnimation('walk-up')
    elseif love.keyboard.isDown('down') then
        self.player.direction = 'down'
        self.player:changeAnimation('walk-down')
    else
        self.player:changeState('idle')
    end

    if love.keyboard.wasPressed('space') then
        self.player:changeState('swing-sword')
    end

    -- perform base collision detection against walls
    self.bumped = updateEntityWithinRoom(dt, self.player, self.dungeon.currentRoom.objects)

    -- if we bumped something when checking collision, check any object collisions
    if self.bumped then
        if self.player.direction == 'left' then
            
            -- temporarily adjust position into the wall, since bumping pushes outward
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.player:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.player.y = doorway.y + 4
                    Event.dispatch('shift-left')
                end
            end

            -- readjust
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
        elseif self.player.direction == 'right' then
            
            -- temporarily adjust position
            self.player.x = self.player.x + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.player:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.player.y = doorway.y + 4
                    Event.dispatch('shift-right')
                end
            end

            -- readjust
            self.player.x = self.player.x - PLAYER_WALK_SPEED * dt
        elseif self.player.direction == 'up' then
            
            -- temporarily adjust position
            self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.player:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.player.x = doorway.x + 8
                    Event.dispatch('shift-up')
                end
            end

            -- readjust
            self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
        else
            
            -- temporarily adjust position
            self.player.y = self.player.y + PLAYER_WALK_SPEED * dt
            
            -- check for colliding into doorway to transition
            for k, doorway in pairs(self.dungeon.currentRoom.doorways) do
                if self.player:collides(doorway) and doorway.open then

                    -- shift entity to center of door to avoid phasing through wall
                    self.player.x = doorway.x + 8
                    Event.dispatch('shift-down')
                end
            end

            -- readjust
            self.player.y = self.player.y - PLAYER_WALK_SPEED * dt
        end
    end
end

function PlayerWalkState:render()
    local anim = self.player.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.player.x - self.player.offsetX), math.floor(self.player.y - self.player.offsetY))
    
    -- debug code
    -- love.graphics.setColor(255, 0, 255, 255)
    -- love.graphics.rectangle('line', self.player.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(255, 255, 255, 255)
end
