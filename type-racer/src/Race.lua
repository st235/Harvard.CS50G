Race = Class{}

function Race:init(x, y, width, height, player, opponents, distance)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.isStarted = false
    self.startTime = -1
    self.opponentsTime = {}

    self.vehicles = {}
    self.lanes = {}
    self.finished = {}
    self.finishedTimings = {}
    self.place = 1

    self.onDriverFinished = function(driverId, place, timing) end
    self.onRaceOver = function(playerPlace, playerTime) end

    for i = 1, #opponents do
        table.insert(self.vehicles, opponents[i])
        local opponentTime = distance / self.vehicles[i].speed
        table.insert(self.opponentsTime, opponentTime)
    end

    -- player's should always be the last entrance in the table
    table.insert(self.vehicles, player)

    local vehiclesHeight = 0
    for _, vehicle in ipairs(self.vehicles) do
        vehiclesHeight = vehiclesHeight + vehicle.height
    end

    local offsetY = self.height - vehiclesHeight
    for i, vehicle in ipairs(self.vehicles) do
        local lane = Lane(self.x, self.y + offsetY, self.width, vehicle.height, vehicle)

        lane.onFinish = function(driverId)
            if self.isStarted then
                self.finished[driverId] = self.place
                self.finishedTimings[driverId] = os.time()
                self.place = self.place + 1

                local finishTime = self.finishedTimings[driverId] - self.startTime
                self.onDriverFinished(driverId, self.finished[driverId], finishTime)
            end
        end

        offsetY = offsetY + lane.height
        table.insert(self.lanes, lane)
    end
end

function Race:getPlayerPlace()
    local playerId = self.vehicles[#self.vehicles].driverId
    return self.finished[playerId] or PLACE_NOT_QUALIFIED
end

function Race:getPlayerTime()
    local playerId = self.vehicles[#self.vehicles].driverId
    if self.finishedTimings[playerId] then
        return self.finishedTimings[playerId] - self.startTime
    end

    return TIME_NO_TIME
end

function Race:hasPlayerFinished()
    local playerId = self.vehicles[#self.vehicles].driverId
    if self.finished[playerId] then
        return true
    else
        return false
    end
end

function Race:hasOpponentsFinish()
    for i=1, #self.vehicles - 1 do
        local opponentId = self.vehicles[i].driverId
        if not self.finished[opponentId] then
            return false
        end
    end

    return true
end

function Race:start()
    assert(not self.isStarted)

    self.isStarted = true
    self.startTime = os.time()

    for i=1, #self.lanes - 1 do
        self.lanes[i]:setProgress(1.0, self.opponentsTime[i])
    end
end

function Race:setPlayerProgress(newProgress)
    self.lanes[#self.lanes]:setProgress(newProgress, 0.4)
end

function Race:update(dt)
    for i=1, #self.lanes do
        self.lanes[i]:update(dt)
    end

    if self.isStarted and (self:hasPlayerFinished() or self:hasOpponentsFinish()) then
        self.isStarted = false
        self.onRaceOver(self:getPlayerPlace(), self:getPlayerTime())
    end
end

function Race:render()
    for i=1, #self.lanes do
        self.lanes[i]:render()
    end
end
