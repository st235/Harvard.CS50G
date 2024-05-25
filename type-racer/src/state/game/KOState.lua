KOState = Class{__includes = BaseState}

function KOState:init(bossVehicle, onFinish)
    self.bossVehicle = bossVehicle
    self.onFinish = onFinish or function() end
end

function KOState:enter()
    gSounds['ko']:stop()
    gSounds['ko']:setVolume(1.0)
    gSounds['ko']:play()

    self.font = gFonts['xxlarge-inv']
    self.alpha = 1
    self.rotation = math.random(-2, 2) * math.pi / 180
    self.koLabelWidth = 150
    self.koLabelHeight = self.font:getHeight()

    Timer.every(0.15, function()
        if self.alpha == 0 then
            self.alpha = 1
        else
            self.alpha = 0
        end
    end)

    Timer.tween(0.4, {
        [self.bossVehicle] = { rotation = math.random(-25, -10) * math.pi / 180 }
    }):finish(function()
        Timer.tween(1, {
            [self.bossVehicle] = { y = VIRTUAL_HEIGHT + self.bossVehicle.height }
        }):finish(function()
            Timer.after(1, self.onFinish)
        end)
    end)
end

function KOState:exit()
    gSounds['ko']:stop()
end

function KOState:render()
    love.graphics.setColor(1, 1, 1, self.alpha)

    love.graphics.printf('K.O.', self.font,
        math.floor(VIRTUAL_WIDTH - self.koLabelWidth) / 2, math.floor(VIRTUAL_HEIGHT - self.koLabelHeight) / 2,
            self.koLabelWidth, 'center', self.rotation)

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
