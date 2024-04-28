--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ICON_PADDING = 6

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
    self.scoreText = love.graphics.newText(mediumFont, 'Score: ' .. tostring(self.score))
    self.trophy = Trophy.create(params.score)
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')


    local trophySize = self.trophy:getSize()
    
    -- score block is a block of text with score followed by optional trophy icon
    local scoreBlockWidth = self.scoreText:getWidth()
    if trophySize > 0 then
        scoreBlockWidth = scoreBlockWidth + trophySize + ICON_PADDING
    end
    local scoreBlockHeight = math.max(self.scoreText:getHeight(), trophySize)

    -- position where the block starts
    local scoreBlockStartX = (VIRTUAL_WIDTH - scoreBlockWidth) / 2

    local textVerticalOffsetInBlock = (scoreBlockHeight - self.scoreText:getHeight()) / 2
    love.graphics.draw(self.scoreText, scoreBlockStartX, 100 + textVerticalOffsetInBlock)

    local trophyHorizontalOffsetInBlock = self.scoreText:getWidth() + ICON_PADDING
    local trophyVerticalOffsetInBlock = (scoreBlockHeight - trophySize) / 2
    self.trophy:draw(scoreBlockStartX + trophyHorizontalOffsetInBlock, 100 + trophyVerticalOffsetInBlock)

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end