CountDownState = Class{__includes = BaseState}

function CountDownState:init(startTime)
    self.startTime = startTime or 3
end

function CountDownState:enter()
    self.font = gFonts['xxlarge']
    self:countDown(self.startTime)

    Timer.every(1, function()
        if self.timer > 1 then
            self:countDown(self.timer - 1)
        else
            -- pop when the countdown is over
            gStateStack:pop()
        end
    end):limit(self.timer)
end

function CountDownState:countDown(newTimer)
    self.timer = newTimer
    self.rotationDeg = math.random(-5, 5)
    self.scale = 5

    Timer.tween(1, {
        [self] = { scale = 1, rotationDeg = 0 }
    })
end

function CountDownState:exit()
end

function CountDownState:update(dt)
end

function CountDownState:render()
    love.graphics.setColor(0, 0, 0, 0.45)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    
    local text = love.graphics.newText(self.font, tostring(self.timer))

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(text, 
        math.floor((VIRTUAL_WIDTH - text:getWidth() * self.scale) / 2), math.floor((VIRTUAL_HEIGHT - text:getHeight() * self.scale) / 2),
        math.pi / 180 * self.rotationDeg, self.scale, self.scale)

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
