VictoryState = Class{__includes = BaseState}

function VictoryState:init(message, color, duration, onFinish)
    self.message = message
    self.color = color or { 255, 255, 255 }
    self.duration = duration or 6
    self.onFinish = onFinish or function() end
end

function VictoryState:enter()
    gSounds['tada']:stop()
    gSounds['tada']:play()

    local labelHeight = 40

    self.label = Label(0, -labelHeight,
        VIRTUAL_WIDTH, labelHeight, 
        self.message, gFonts['xlarge'], 
        { 255, 255, 255 }, 'center', 'center')
    self.label:setBackground(Rectangle())

    self.psystem = love.graphics.newParticleSystem(gTextures['confetti'], 512)

	self.psystem:setParticleLifetime(2, 10)
	self.psystem:setEmissionRate(100)
    self.psystem:setSpin(1, math.pi * 4)
    self.psystem:setEmissionArea('uniform', VIRTUAL_WIDTH / 2, 0)
	self.psystem:setLinearAcceleration(-5, 0, 5, 60)
	self.psystem:setColors(
        self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 1,
        self.color[1] / 255, self.color[2] / 255, self.color[3] / 255, 0)

    Timer.tween(self.duration / 4, {
        [self.label] = { y = math.floor((VIRTUAL_HEIGHT - labelHeight) / 2) }
    }):finish(function()
        Timer.after(self.duration / 2, function()
            Timer.tween(self.duration / 4, {
                [self.label] = { y = VIRTUAL_HEIGHT + labelHeight }
            }):finish(self.onFinish)
        end)
    end)
end

function VictoryState:exit()
    gSounds['tada']:stop()
end

function VictoryState:update(dt)
    self.psystem:update(dt)
end

function VictoryState:render()
    love.graphics.draw(self.psystem, VIRTUAL_WIDTH / 2, 0)
    self.label:render()
end
