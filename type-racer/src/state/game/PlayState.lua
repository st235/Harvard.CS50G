PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.tileMap = TileMap(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    -- self.panel = Panel(panelX, panelY, panelWidth, panelHeight)
    self.matcher = TemplateMatcher(math.floor((VIRTUAL_WIDTH - 200) / 2), 10, 200, 90, 
        'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'], 'left',
        {255, 255, 255}, {0, 255, 0}, {255, 0, 0},
        8, 6, 8, 6)
    self.matcher:setBackground(Panel())
    
    self.raceStarted = false
    self.race = Race(32, VIRTUAL_HEIGHT - 32 * 4, VIRTUAL_WIDTH - 64, 32 * 4, 3, self.matcher:getSymbolsCount())

    self.race.onDriverFinished = function(driverId, place, timing)
        print('Finished', driverId, place, timing)
    end

    self.race.onRaceOver = function(place, timing)
        print('Race is over', place, timing)
    end

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

    if love.keyboard.wasPressed('space') and not self.raceStarted then
        self.raceStarted = true
        self.race:start()
    end
end

function PlayState:render()
    love.graphics.clear(0, 0, 0, 1)

    self.tileMap:render()
    self.matcher:render()
    self.race:render()
end
