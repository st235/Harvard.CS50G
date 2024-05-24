GameOverState = Class{__includes = BaseState}

function GameOverState:init(message, x, y, minRadius, duration, onFinish)
    self.message = message
    self.x = x
    self.y = y
    self.minRadius = minRadius or 10
    self.maxRadius = math.max(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.duration = duration or 4
    self.onFinish = onFinish or function() end
end

function GameOverState:enter()
    self.radius = self.maxRadius

    local labelHeight = 40
    self.label = Label(0, math.floor((VIRTUAL_HEIGHT - labelHeight) / 2),
        VIRTUAL_WIDTH, labelHeight, 
        self.message, gFonts['xlarge'], 
        { 255, 255, 255 }, 'center', 'center')
    self.label.alpha = 0

    Timer.tween(self.duration / 2, {
        [self] = { radius = self.minRadius }
    }):finish(function()
        Timer.tween(self.duration / 2, {
            [self.label] = { alpha = 255 }
        }):finish(self.onFinish)
    end)
end

function GameOverState:render()
    -- stencil out the door arches so it looks like the player is going through
    love.graphics.stencil(function()
        love.graphics.setColor(1, 1, 1, 0)
        love.graphics.circle('fill', self.x, self.y, self.radius)
    end, 'replace', 1)

    love.graphics.setStencilTest('less', 1)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    self.label:render()

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
