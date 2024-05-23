Race = Class{}

function Race:init(x, y, width, height, opponents)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.isStarted = false
    self.opponentsSpeed = {}

    self.vehicles = {}
    self.lanes = {}

    for i = 1, opponents do
        table.insert(self.vehicles, Car(0, 0, 32, 24, { 1, 2 }, { 255, 255, 255 }))

        local opponentSpeed = math.random(5, 15) / 100
        table.insert(self.opponentsSpeed, opponentSpeed)
    end

    -- player's should always be the last entrance in the table
    table.insert(self.vehicles, Car(0, 0, 32, 24, { 1, 2 }))

    local vehiclesHeight = 0
    for _, vehicle in ipairs(self.vehicles) do
        vehiclesHeight = vehiclesHeight + vehicle.height
    end

    local offsetY = self.height - vehiclesHeight
    for _, vehicle in ipairs(self.vehicles) do
        local lane = Lane(self.x, self.y + offsetY, self.width, vehicle.height, vehicle)

        offsetY = offsetY + lane.height
        table.insert(self.lanes, lane)
    end
end

function Race:start()
    self.isStarted = true

    Timer.every(1, function()
        for i=1, #self.lanes - 1 do
            self.lanes[i]:appendProgress(self.opponentsSpeed[i])
        end
    end)
end

function Race:setPlayerProgress(newProgress)
    self.lanes[#self.lanes]:setProgress(newProgress)
end

function Race:update(dt)
    for i=1, #self.lanes do
        self.lanes[i]:update(dt)
    end
end

function Race:render()
    for i=1, #self.lanes do
        self.lanes[i]:render()
    end
end
