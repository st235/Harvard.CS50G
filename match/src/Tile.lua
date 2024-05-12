--[[
    GD50
    Match-3 Remake

    -- Tile Class --

    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The individual tiles that make up our game board. Each Tile can have a
    color and a variety, with the varietes adding extra points to the matches.
]]

SHINY_TILE_CHANCE = 6

Tile = Class{}

Tile.SIZE = 32

function Tile.shouldBeShiny()
    return math.random(1, 100) <= SHINY_TILE_CHANCE
end

function Tile:init(x, y, color, variety, isShiny)
    
    -- board positions
    self.gridX = x
    self.gridY = y

    -- coordinate positions
    self.x = (self.gridX - 1) * Tile.SIZE
    self.y = (self.gridY - 1) * Tile.SIZE

    -- tile appearance/points
    self.color = color
    self.variety = variety

    -- denotes whether the tile can destroy the entire row
    self.isShiny = isShiny or false
    self.shinyAnimationIndex = 0

    if self.isShiny then
        Timer.every(0.16, function()
            self.shinyAnimationIndex = (self.shinyAnimationIndex + 1) % 6
        end)
    end
end

function Tile:render(x, y)
    -- draw shadow
    love.graphics.setColor(34/255, 32/255, 52/255, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x + 2, self.y + y + 2)

    -- draw tile itself
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.draw(gTextures['main'], gFrames['tiles'][self.color][self.variety],
        self.x + x, self.y + y)

    if self.isShiny then
        love.graphics.setColor(1, 215/255, 0, 1)
        love.graphics.draw(gTextures['shiny-animation'], gFrames['shiny-animation'][self.shinyAnimationIndex + 1], 
            self.x + x + 3, self.y + y + 3, 0, 0.45, 0.45)
    end
end