-- 3rd party libraries
Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'

require 'src/StateStack'
require 'src/StateMachine'

-- definitions
require 'src/levels_defs'
require 'src/opponents_defs'

-- game states
require 'src/state/BaseState'
require 'src/state/game/StartState'
require 'src/state/game/PlayState'

-- gui:
-- -- views
require 'src/gui/view/View'
require 'src/gui/view/Label'
require 'src/gui/view/TemplateMatcher'
require 'src/gui/view/Leaderboard'

-- -- backgrounds
require 'src/gui/background/Circle'
require 'src/gui/background/Panel'

-- utils
require 'src/utils/Animation'
require 'src/utils/Queue'
require 'src/utils/StringUtil'
require 'src/utils/TileUtil'

-- entities
require 'src/Vehicle'
require 'src/Lane'
require 'src/Race'

-- world
require 'src/Tile'
require 'src/TileMap'
require 'src/Level'

gTextures = {
    ['cars'] = love.graphics.newImage('resources/graphics/carsheet.png'),
    ['motos'] = love.graphics.newImage('resources/graphics/motosheet.png'),
    ['ground'] = love.graphics.newImage('resources/graphics/groundsheet.png'),
    ['buildings'] = love.graphics.newImage('resources/graphics/buildingsheet.png'),
    ['trophies'] = love.graphics.newImage('resources/graphics/trophysheet.png'),
}

gFrames = {
    ['cars'] = GenerateQuads(gTextures['cars'], 32, 24),
    ['motos'] = GenerateQuads(gTextures['motos'], 24, 16),
    ['ground'] = GenerateQuads(gTextures['ground'], 16, 16),
    ['buildings'] = {
        love.graphics.newQuad(0, 0, 48, 88, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(48, 0, 56, 88, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(104, 0, 72, 104, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(176, 5, 64, 115, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(240, 0, 56, 104, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(296, 0, 64, 128, gTextures['buildings']:getDimensions()),
        love.graphics.newQuad(368, 0, 73, 128, gTextures['buildings']:getDimensions()),
    },
    ['trophies'] = GenerateQuads(gTextures['trophies'], 16, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 16),
    ['medium'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 32),  
    ['large'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 48),
}