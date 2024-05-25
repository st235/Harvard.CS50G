Level = Class{}

function Level:init(x, y, width, height, levelId, levelDef)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.levelId = levelId
    self.levelDef = levelDef
   
    self.onWin = function(isBossFight) end
    self.onLose = function(reason, isBossFight, playerCoords) end

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
        self.levelId, 1,
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
        gSounds['keyboard-click']:stop()
        gSounds['keyboard-click']:play()
        self.race:setPlayerProgress(p)
    end

    self.matcher.onError = function(s, p)
        gSounds['error']:stop()
        gSounds['error']:play()
    end

    self.matcher.onErrorLimitExceed = function()
        if self.race.isStarted then
            local coords = self.race:getPlayerCenterCoordinates()
            self.onLose(LEVEL_LOST_REASON_TYPOS, self.bossFight, coords)
            self.race.isStarted = false
        end
    end

    self.race.onDriverFinished = function(driverId, place, timing)
        print('Finished', driverId, place, timing)
    end

    self.race.onRaceOver = function(place, timing, coords)
        if place == PLACE_NOT_QUALIFIED then
            self.onLose(LEVEL_LOST_REASON_KILLED, self.bossFight, coords)
        else
            self.onWin(self.isBossFight)
        end
    end

    Timer.every(0.1, function()
        if self.race.isStarted then
            self.statsview:setSpeed(self:getPlayerSpeed())
            self.statsview:setPosition(self.race:getPlayerProjectedPlace())
        end
    end)
end

function Level:createVehicle(def)
    return Vehicle(0, 0, def.width, def.height,
        def.driverId, def.name,
        -- definition contains symbols per minute 
        (def.speed or 0) / 60, 
        def.texture, def.frames, def.tint)
end

function Level:start()
    self.race:start()
end

-- returns speed in symbols per minute
function Level:getPlayerSpeed()
    local elapsedTime = self.race:getElapsedTime()
    if elapsedTime == 0 then
        -- the first second of the game
        return 0
    end
    return math.floor(self.matcher:getMatchedSymbolsCount() / elapsedTime * 60)
end

function Level:getLeaderboard()
    local lookup = {}
    local playerId = self.race:getPlayerId()

    for i=1,#self.race.vehicles do
        local id = self.race.vehicles[i].driverId

        if id == playerId then
            local timing = self.race:getPlayerTime()
            if timing == TIME_NO_TIME then
                timing = nil
            end

            table.insert(lookup, { 
                id = id,
                originalOrdering = i,
                timing = timing
             })
        else
            table.insert(lookup, {
                id = id,
                originalOrdering = i,
                timing = self.race.distance / self.race.vehicles[i].speed
             })
        end
    end

    table.sort(lookup, function(a, b)
        if not a.timing then
            assert(b.timing)
            return false
        elseif not b.timing then
            return true
        else
            return a.timing < b.timing
        end
    end)

    local leaderboard = {}

    for i=1,#lookup do
        local id = lookup[i].id
        local originalOrdering = lookup[i].originalOrdering
        local name = self.race.vehicles[originalOrdering].driverName
        
        local place = i
        local timing = lookup[i].timing
        if timing then
            timing = string.format("%.2f", timing)
        else
            timing = 'N/A'
        end

        local speed = nil
        if id == playerId then
            speed = self:getPlayerSpeed()
        else
            speed = math.floor(self.race.vehicles[originalOrdering].speed * 60)
        end

        assert(speed)

        table.insert(leaderboard, {
            ['driverId'] = id,
            ['driverName'] = name,
            ['driverSpeed'] = speed,
            ['place'] = place,
            ['timing'] = timing,
        })
    end

    return leaderboard
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
