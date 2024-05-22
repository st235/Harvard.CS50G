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

gTextures = {
    ['vehicles'] = love.graphics.newImage('resources/graphics/vehicles.png'),
}

gFrames = {
    ['vehicles'] = GenerateQuads(gTextures['vehicles'], 32, 24),
}

gFonts = {
    ['small'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 16),
    ['medium'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 32),  
    ['large'] = love.graphics.newFont('resources/fonts/Bitty.ttf', 48),
}