CircleOutState = Class{__includes = BaseState}

function CircleOutState:init(x, y, minRadius, maxRadius, duration)
    self.x = x
    self.y = y
    self.minRadius = minRadius or 10
    self.maxRadius = maxRadius or math.max(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.duration = duration or 2
end

function CircleOutState:enter(params)
    self.radius = self.maxRadius

    Timer.tween(self.duration, {
        [self] = { radius = self.minRadius }
    })
end

function CircleOutState:countDown(newTimer)
end

function CircleOutState:exit()
end

function CircleOutState:update(dt)
end

function CircleOutState:render()
    -- stencil out the door arches so it looks like the player is going through
    love.graphics.stencil(function()
        love.graphics.setColor(1, 1, 1, 0)
        love.graphics.circle('fill', self.x, self.y, self.radius)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
