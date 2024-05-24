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
require 'src/state/game/CountDownState'
require 'src/state/game/StartState'
require 'src/state/game/PlayState'
require 'src/state/game/FadeInState'
require 'src/state/game/FadeOutState'
require 'src/state/game/GameOverState'
require 'src/state/game/VictoryState'
require 'src/state/game/LeaderboardState'

-- gui:
-- -- views
require 'src/gui/view/View'
require 'src/gui/view/Label'
require 'src/gui/view/Icon'
require 'src/gui/view/TemplateMatcher'
require 'src/gui/view/LeaderboardRow'
require 'src/gui/view/Leaderboard'
require 'src/gui/view/StatsView'

-- -- backgrounds
require 'src/gui/background/Circle'
require 'src/gui/background/Panel'
require 'src/gui/background/Rectangle'

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
    ['confetti'] = love.graphics.newImage('resources/graphics/confetti.png'),
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
    ['small'] = love.graphics.newFont('resources/fonts/KitchenSink.ttf', 8),
    ['medium'] = love.graphics.newFont('resources/fonts/KitchenSink.ttf', 16),
    ['large'] = love.graphics.newFont('resources/fonts/KitchenSink.ttf', 24),
    ['xlarge'] = love.graphics.newFont('resources/fonts/KitchenSink.ttf', 32),
    ['xxlarge'] = love.graphics.newFont('resources/fonts/KitchenSink.ttf', 48),
    ['small-inv'] = love.graphics.newFont('resources/fonts/KitchenSinkInv.ttf', 8),
    ['medium-inv'] = love.graphics.newFont('resources/fonts/KitchenSinkInv.ttf', 16),
    ['large-inv'] = love.graphics.newFont('resources/fonts/KitchenSinkInv.ttf', 24),
    ['xlarge-inv'] = love.graphics.newFont('resources/fonts/KitchenSinkInv.ttf', 32),
    ['xxlarge-inv'] = love.graphics.newFont('resources/fonts/KitchenSinkInv.ttf', 48),
}