CreditsState = Class{__includes = BaseState}

function CreditsState:init()
    self.shouldScroll = false
end

function CreditsState:enter()
    gSounds['outro']:stop()
    gSounds['outro']:setLooping(true)
    gSounds['outro']:setVolume(0.1)
    gSounds['outro']:play()

    self.creditsHeight = 1610
    self.creditsLabel = Label(0, 20, VIRTUAL_WIDTH, self.creditsHeight,
        CREDITS, gFonts['large'], { 255, 255, 255 }, 'center', 'top')
end

function CreditsState:exit()
    gSounds['outro']:stop()
end

function CreditsState:update(dt)
    if not self.shouldScroll then
        self.shouldScroll = true

        Timer.tween(30, {
            [self.creditsLabel] = { y = VIRTUAL_HEIGHT - self.creditsHeight}
        }):finish(function()
            -- pop credits state
            gStateStack:pop()
    
            gStateStack:push(FadeOutState({ 0, 0, 0 }, 0, 1, function()
                -- pop fade out state
                gStateStack:pop()
            end))
        end)
    end
end

function CreditsState:render()
    love.graphics.clear(0, 0, 0, 1)
    self.creditsLabel:render()
end
