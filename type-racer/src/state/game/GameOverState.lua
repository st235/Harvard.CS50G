GameOverState = Class{__includes = BaseState}

function GameOverState:init(title, description, x, y, minRadius, duration, onFinish)
    self.title = title
    self.description = description
    self.x = x
    self.y = y
    self.minRadius = minRadius or 10
    self.maxRadius = math.max(VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.duration = duration or 4
    self.onFinish = onFinish or function() end
end

function GameOverState:enter()
    gSounds['lose']:stop()
    gSounds['lose']:play()

    self.radius = self.maxRadius

    local labelsSpacing = 4
    local gameOverLabelHeight = 40
    local descriptionLabelHeight = 22
    local allLabelsHeight = gameOverLabelHeight + descriptionLabelHeight + labelsSpacing

    self.gameOverLabel = Label(0, math.floor((VIRTUAL_HEIGHT - allLabelsHeight) / 2),
        VIRTUAL_WIDTH, gameOverLabelHeight, 
        self.title, gFonts['large'], 
        { 255, 255, 255 }, 'center', 'center')
    self.gameOverLabel.alpha = 0

    self.descriptionLabel = Label(0, math.floor((VIRTUAL_HEIGHT - allLabelsHeight) / 2 + gameOverLabelHeight + labelsSpacing),
        VIRTUAL_WIDTH, descriptionLabelHeight, 
        self.description, gFonts['medium'], 
        { 169, 169, 169 }, 'center', 'center',
        0, 32, 0, 32)
    self.descriptionLabel.alpha = 0

    Timer.tween(self.duration / 2, {
        [self] = { radius = self.minRadius }
    }):finish(function()
        Timer.tween(self.duration / 2, {
            [self.gameOverLabel] = { alpha = 255 },
            [self.descriptionLabel] = { alpha = 255 },
        }):finish(self.onFinish)
    end)
end

function GameOverState:exit()
    gSounds['lose']:stop()
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

    self.gameOverLabel:render()
    self.descriptionLabel:render()

    -- reset colors
    love.graphics.setColor(1, 1, 1, 1)
end
