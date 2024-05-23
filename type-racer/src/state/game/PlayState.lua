PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.TileMap = TileMap(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    self.matcher = TemplateMatcher(20, 20, 150, 100, 'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
    
    self.raceStarted = false
    self.race = Race(32, VIRTUAL_HEIGHT - 32 * 4, VIRTUAL_WIDTH - 64, 32 * 4, 3)

    self.matcher.onMatch = function(s, p)
        self.race:setPlayerProgress(p)
    end
end

function PlayState:exit()
end

function PlayState:update(dt)
    self.race:update(dt)

    if self.raceStarted then
        self.matcher:update(dt)
    end

    if love.keyboard.wasPressed('space') then
        self.raceStarted = true
        self.race:start()
    end
end

function PlayState:render()
    love.graphics.clear(0, 0, 0, 1)

    self.TileMap:render()
    self.matcher:render()
    self.race:render()
end
