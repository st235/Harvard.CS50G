FadeInState = Class{__includes = BaseState}

function FadeInState:init(color, duration, onFinish)
    assert(#color == 3)
    self.color = color
    self.duration = duration or 2
    self.onFinish = onFinish or function() end
end

function FadeInState:enter()
    self.alpha = 0

    Timer.tween(self.duration, {
        [self] = { alpha = 1.0 }
    }):finish(function()
        self.onFinish()
    end)
end

function FadeInState:render()
    love.graphics.setColor(self.color[1]/255, self.color[2]/255, self.color[3]/255, self.alpha)
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
