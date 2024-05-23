-- 3rd party libraries
Class = require 'lib/class'
Event = require 'lib/knife.event'
push = require 'lib/push'
Timer = require 'lib/knife.timer'

require 'src/Constants'

require 'src/StateStack'
require 'src/StateMachine'

-- game states
require 'src/state/BaseState'
require 'src/state/game/StartState'
require 'src/state/game/PlayState'

-- gui
require 'src/gui/Label'
require 'src/gui/TemplateMatcher'

-- utils
require 'src/utils/Animation'
require 'src/utils/Queue'
require 'src/utils/StringUtil'
require 'src/utils/TileUtil'

-- entities
require 'src/Car'
require 'src/Lane'
require 'src/Race'

gTextures = {
    ['cars'] = love.graphics.newImage('resources/graphics/carsheet.png'),
    ['motos'] = love.graphics.newImage('resources/graphics/motosheet.png'),
}

gFrames = {
    ['cars'] = GenerateQuads(gTextures['cars'], 32, 24),
    ['motos'] = GenerateQuads(gTextures['motos'], 24, 16),
}

gFonts = {
    ['small'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 16),
    ['medium'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 32),  
    ['large'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 48),
}