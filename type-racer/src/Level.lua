Level = Class{}

function Level:init(x, y, width, height, level)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.level = level
   
    self.onWin = function() end
    self.onLose = function(reason, playerCoords) end

    local allLevelDefs = LEVELS[level]
    local levelDef = allLevelDefs[math.random(#allLevelDefs)]

    self.bossFight = levelDef.bossFight or false
    self.allowedTypos = levelDef.allowedTypos or MAXIMUM_ERROR_ACCUMULATION_LENGTH
    
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

    local controlsWidth = LEADERBOARD_WIDTH + VIEWS_SPACING + INPUT_WIDTH
    local controlsOffsetX = math.floor((self.width - controlsWidth) / 2)
    local controlsPaddingTop = 10

    self.statsview = StatsView(self.x + controlsOffsetX, self.y + controlsPaddingTop, 
        LEADERBOARD_WIDTH, LEADERBOARD_HEIGHT, 
        gFonts['small-inv'], gFonts['small'], gFonts['medium'], 
        level, 1,
        6, 6, 6, 6)
    self.statsview:setBackground(Panel())

    self.matcher = TemplateMatcher(self.x + controlsOffsetX + LEADERBOARD_WIDTH + VIEWS_SPACING, self.y + controlsPaddingTop, 
        INPUT_WIDTH, INPUT_HEIGH,
        text, self.allowedTypos, gFonts['small'], 'left',
        {255, 255, 255}, {155, 188, 15}, {238, 28, 37},
        8, 8, 8, 8)
    self.matcher:setBackground(Panel())

    local raceHorizontalPadding = 32
    local roadHeight = self.tileMap:getRoadHeight()
    local raceVerticalOffset = math.max(0, math.floor((roadHeight - raceHeight) / 2))

    self.race = Race(raceHorizontalPadding, self.tileMap:getRoadOffsetY() + raceVerticalOffset, 
        self.width - 2 * raceHorizontalPadding, raceHeight, 
        player, opponents, self.matcher:getSymbolsCount())

    self.matcher.onMatch = function(s, p)
        self.race:setPlayerProgress(p)
    end

    self.matcher.onErrorLimitExceed = function()
        local coords = self.race:getPlayerCenterCoordinates()
        self.onLose(LEVEL_LOST_REASON_TYPOS, coords)
    end

    self.race.onDriverFinished = function(driverId, place, timing)
        print('Finished', driverId, place, timing)
    end

    self.race.onRaceOver = function(place, timing, coords)
        if place == PLACE_NOT_QUALIFIED then
            if self.bossFight then
                self.onLose(LEVEL_LOST_REASON_BOSS_KILLED, coords)
            else
                self.onLose(LEVEL_LOST_REASON_KILLED, coords)
            end
        else
            self.onWin()
        end
    end

    Timer.every(0.1, function()
        if self.race.isStarted then
            self.statsview:setSpeed(self:getSpeed())
            self.statsview:setPosition(self.race:getPlayerProjectedPlace())
        end
    end)
end

function Level:createVehicle(def)
    return Vehicle(0, 0, def.width, def.height,
        def.driverId,
        -- definition contains symbols per minute 
        (def.speed or 0) / 60, 
        def.texture, def.frames, def.tint)
end

function Level:start()
    self.race:start()
end

-- returns speed in symbols per minute
function Level:getSpeed()
    local elapsedTime = self.race:getElapsedTime()
    if elapsedTime == 0 then
        -- the first second of the game
        return 0
    end
    return math.floor(self.matcher:getMatchedSymbolsCount() / elapsedTime * 60)
end

function Level:update(dt)
    self.race:update(dt)

    if self.race.isStarted then
        self.statsview:update(dt)
        self.matcher:update(dt)
    end
end

function Level:render()
    love.graphics.clear(0, 0, 0, 1)

    self.tileMap:render()
    self.statsview:render()
    self.matcher:render()
    self.race:render()
end
