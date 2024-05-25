FadeOutState = Class{__includes = BaseState}

function FadeOutState:init(color, finalAlpha, duration, onFinish)
    assert(#color == 3)
    self.color = color
    self.finalAlpha = finalAlpha or 0.0
    self.duration = duration or 2
    self.onFinish = onFinish or function() end
end

function FadeOutState:enter()
    self.alpha = 1.0

    Timer.tween(self.duration, {
        [self] = { alpha = self.finalAlpha }
    }):finish(function()
        self.onFinish()
    end)
end

function FadeOutState:render()
    love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255, self.alpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
