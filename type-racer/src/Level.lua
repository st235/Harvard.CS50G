Level = Class{}

function Level:init(x, y, width, height, level)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.level = level
    
    local allLevelDefs = LEVELS[level]
    local levelDef = allLevelDefs[math.random(#allLevelDefs)]

    local text = levelDef.text
    local opponentIds = levelDef.opponents

    local player = self:createVehicle(PLAYER)
    local raceHeight = player.height

    local opponents = {}
    for i, id in ipairs(opponentIds) do
        table.insert(opponents, self:createVehicle(OPPONENTS[id]))
        raceHeight = raceHeight + opponents[i].height
    end

    self.tileMap = TileMap(0, 0, self.width, self.height)

    -- self.panel = Panel(panelX, panelY, panelWidth, panelHeight)
    self.matcher = TemplateMatcher(math.floor((self.width - 200) / 2), 10, 200, 90, 
        text, gFonts['small'], 'left',
        {255, 255, 255}, {0, 255, 0}, {255, 0, 0},
        8, 6, 8, 6)
    self.matcher:setBackground(Panel())
    
    self.raceStarted = false

    local raceHorizontalPadding = 32
    local roadHeight = self.tileMap:getRoadHeight()
    local raceVerticalOffset = math.max(0, math.floor((roadHeight - raceHeight) / 2))

    self.race = Race(raceHorizontalPadding, self.tileMap:getRoadOffsetY() + raceVerticalOffset, 
        self.width - 2 * raceHorizontalPadding, raceHeight, 
        player, opponents, self.matcher:getSymbolsCount())

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

function Level:createVehicle(def)
    return Vehicle(0, 0, def.width, def.height,
        def.driverId, def.speed, def.texture,
        def.frames, def.tint)
end

function Level:update(dt)
    self.race:update(dt)

    if self.raceStarted then
        self.matcher:update(dt)
    end

    if love.keyboard.wasPressed('space') and not self.raceStarted then
        self.raceStarted = true
        self.race:start()
    end
end

function Level:render()
    love.graphics.clear(0, 0, 0, 1)

    self.tileMap:render()
    self.matcher:render()
    self.race:render()
end
