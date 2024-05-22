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

gFonts = {
    ['small'] = love.graphics.newFont('resources/fonts/font.ttf', 8),
    ['medium'] = love.graphics.newFont('resources/fonts/font.ttf', 12),
    ['large'] = love.graphics.newFont('resources/fonts/font.ttf', 32)
}
