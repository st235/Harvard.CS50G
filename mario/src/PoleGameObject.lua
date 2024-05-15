--[[
    GD50
    Super Mario Bros. Remake

    -- PoleGameObject Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu
]]

PoleGameObject = Class{__includes = GameObject}

function PoleGameObject:init(def)
    GameObject.init(self, def)

    self.width = 16
    self.height = 48

    self.flagSkin = math.random(3)
    self.poleSkin = math.random(6)

    self.flagAnimation = Animation {
        frames = { self.flagSkin * 3 + 1, self.flagSkin * 3 + 2 },
        interval = 0.2
    }
end

function PoleGameObject:update(dt)
    self.flagAnimation:update(dt)
end

function PoleGameObject:render()
    love.graphics.draw(gTextures['poles'], gFrames['poles'][self.poleSkin], math.floor(self.x), math.floor(self.y))
    love.graphics.draw(gTextures['flags'], gFrames['flags'][self.flagAnimation:getCurrentFrame()], 
    math.floor(self.x) + 6, math.floor(self.y) + 4)
end
