--[[
    GD50
    Breakout Remake

    -- PlayState Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    Represents the state of the game in which we are actively playing;
    player should control the paddle, with the ball actively bouncing between
    the bricks, walls, and the paddle. If the ball goes below the paddle, then
    the player should lose one point of health and be taken either to the Game
    Over screen if at 0 health or the Serve screen otherwise.
]]

local PADDLE_PROMOTION_THRESHOLD = 1500

PlayState = Class{__includes = BaseState}

--[[
    We initialize what's in our PlayState via a state table that we pass between
    states as we go from playing to serving.
]]
function PlayState:enter(params)
    self.paddle = params.paddle
    self.bricks = params.bricks
    self.health = params.health
    self.score = params.score
    self.highScores = params.highScores
    self.balls = params.balls
    self.level = params.level

    -- the game always starts with one ball,
    -- and their index is 1.
    assert(#self.balls == 1)
    assert(self.balls[1])

    self.powerups = {}
    self.powerupsLookup = {}

    self.recoverPoints = 5000

    -- give ball random starting velocity
    local ball = self.balls[1]
    ball.dx = math.random(-200, 200)
    ball.dy = math.random(-50, -60)
end

function PlayState:update(dt)
    if self.paused then
        if love.keyboard.wasPressed('space') then
            self.paused = false
            gSounds['pause']:play()
        else
            return
        end
    elseif love.keyboard.wasPressed('space') then
        self.paused = true
        gSounds['pause']:play()
        return
    end

    -- remove dead powerups from the game
    for k, powerup in pairs(self.powerups) do
        if powerup.isDead then
            self.powerupsLookup[powerup.skin] = self.powerupsLookup[powerup.skin] - 1
            table.remove(self.powerups, k)
        end
    end

    -- update positions based on velocity
    self.paddle:update(dt)
    for k, powerup in pairs(self.powerups) do
        powerup:update(dt)

        if powerup:collides(self.paddle) then
            powerup.isDead = true

            assert(#self.balls == 1)
            assert(self.balls[1])

            local currentBall = self.balls[1]

            local newBall1 = currentBall:clone()
            newBall1.dx = newBall1.dx + math.random(5, 10)
            newBall1.dy = newBall1.dy + math.random(0, 5)

            local newBall2 = currentBall:clone()
            newBall2.dx = newBall2.dx - math.random(5, 10)
            newBall2.dy = newBall2.dy + math.random(0, 5)

            table.insert(self.balls, newBall1)
            table.insert(self.balls, newBall2)
        end
    end

    for k, ball in pairs(self.balls) do
        ball:update(dt)

        if ball:collides(self.paddle) then
            -- raise ball above paddle in case it goes below it, then reverse dy
            ball.y = self.paddle.y - 8
            ball.dy = -ball.dy

            --
            -- tweak angle of bounce based on where it hits the paddle
            --

            -- if we hit the paddle on its left side while moving left...
            if ball.x < self.paddle.x + (self.paddle.width / 2) and self.paddle.dx < 0 then
                ball.dx = -50 + -(8 * (self.paddle.x + self.paddle.width / 2 - ball.x))
            
            -- else if we hit the paddle on its right side while moving right...
            elseif ball.x > self.paddle.x + (self.paddle.width / 2) and self.paddle.dx > 0 then
                ball.dx = 50 + (8 * math.abs(self.paddle.x + self.paddle.width / 2 - ball.x))
            end

            gSounds['paddle-hit']:play()
        end

        -- detect collision across all bricks with the ball
        for k, brick in pairs(self.bricks) do

            -- only check collision if we're in play
            if brick.inPlay and ball:collides(brick) then
                local brickCenterX = brick.x + brick.width / 2
                local brickCenterY = brick.y + brick.height / 2

                -- add to score
                local oldScoreLevel = math.floor(self.score / PADDLE_PROMOTION_THRESHOLD)
                self.score = self.score + (brick.tier * 200 + brick.color * 25)

                local newScoreLevel = math.floor(self.score / PADDLE_PROMOTION_THRESHOLD)
                if self.score > 0 and (newScoreLevel > oldScoreLevel) then
                    self.paddle:promote()
                end

                -- trigger the brick's hit function, which removes it from play
                brick:hit()

                -- if the brick is dead now, we can toss a coin and generate powerup
                local willBeTheOnlyExtraBallPowerup = (self.powerupsLookup[Powerup.SKIN_EXTRA_BALL] or 0) == 0
                if not brick.inPlay and willBeTheOnlyExtraBallPowerup and Powerup.shouldSpawnExtraBallPowerup(#self.balls) then
                    table.insert(self.powerups, Powerup(brickCenterX, brickCenterY))
                    self.powerupsLookup[Powerup.SKIN_EXTRA_BALL] = (self.powerupsLookup[Powerup.SKIN_EXTRA_BALL] or 0) + 1
                end

                -- if we have enough points, recover a point of health
                if self.score > self.recoverPoints then
                    -- can't go above 3 health
                    self.health = math.min(3, self.health + 1)

                    -- multiply recover points by 2
                    self.recoverPoints = self.recoverPoints + math.min(100000, self.recoverPoints * 2)

                    -- play recover sound effect
                    gSounds['recover']:play()
                end

                --
                -- collision code for bricks
                --
                -- we check to see if the opposite side of our velocity is outside of the brick;
                -- if it is, we trigger a collision on that side. else we're within the X + width of
                -- the brick and should check to see if the top or bottom edge is outside of the brick,
                -- colliding on the top or bottom accordingly 
                --

                -- left edge; only check if we're moving right, and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                if ball.x + 2 < brick.x and ball.dx > 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x - 8
                
                -- right edge; only check if we're moving left, , and offset the check by a couple of pixels
                -- so that flush corner hits register as Y flips, not X flips
                elseif ball.x + 6 > brick.x + brick.width and ball.dx < 0 then
                    
                    -- flip x velocity and reset position outside of brick
                    ball.dx = -ball.dx
                    ball.x = brick.x + 32
                
                -- top edge if no X collisions, always check
                elseif ball.y < brick.y then
                    
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y - 8
                
                -- bottom edge if no X collisions or top collision, last possibility
                else
                    
                    -- flip y velocity and reset position outside of brick
                    ball.dy = -ball.dy
                    ball.y = brick.y + 16
                end

                -- slightly scale the y velocity to speed up the game, capping at +- 150
                if math.abs(ball.dy) < 150 then
                    ball.dy = ball.dy * 1.02
                end

                -- only allow colliding with one brick, for corners
                break
            end
        end
    end

    -- if ball goes below bounds, revert to serve state and decrease health
    if not self:hasAnyBallInPlay() then
        self.health = self.health - 1
        self.paddle:demote()
        gSounds['hurt']:play()

        if self.health == 0 then
            gStateMachine:change('game-over', {
                score = self.score,
                highScores = self.highScores
            })
        else
            gStateMachine:change('serve', {
                paddle = self.paddle,
                bricks = self.bricks,
                health = self.health,
                score = self.score,
                highScores = self.highScores,
                level = self.level,
                recoverPoints = self.recoverPoints
            })
        end
    end

    -- go to our victory screen if there are no more bricks left
    if self:checkVictory() then
        gSounds['victory']:play()

        gStateMachine:change('victory', {
            level = self.level,
            paddle = self.paddle,
            health = self.health,
            score = self.score,
            highScores = self.highScores,
            ball = self.balls[math.random(1, #self.balls)],
            recoverPoints = self.recoverPoints
        })
    end

    -- remove all dead balls, but keep at least on of them
    -- to pass to victory state.
    for k, ball in pairs(self.balls) do
        if ball.isDead and #self.balls > 1 then
            table.remove(self.balls, k)
        end
    end

    -- for rendering particle systems
    for k, brick in pairs(self.bricks) do
        brick:update(dt)
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    -- render bricks
    for k, brick in pairs(self.bricks) do
        brick:render()
    end

    -- render all particle systems
    for k, brick in pairs(self.bricks) do
        brick:renderParticles()
    end

    self.paddle:render()
    for k, ball in pairs(self.balls) do
        ball:render()
    end

    renderScore(self.score)
    renderHealth(self.health)

    for k, powerup in pairs(self.powerups) do
        powerup:render()
    end

    -- pause text, if paused
    if self.paused then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf("PAUSED", 0, VIRTUAL_HEIGHT / 2 - 16, VIRTUAL_WIDTH, 'center')
    end
end

function PlayState:checkVictory()
    for k, brick in pairs(self.bricks) do
        if brick.inPlay then
            return false
        end 
    end

    return true
end

function PlayState:hasAnyBallInPlay()
    for k, ball in pairs(self.balls) do
        if not ball.isDead then
            return true
        end
    end

    return false
end
