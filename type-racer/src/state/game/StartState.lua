StartState = Class{__includes = BaseState}

function StartState:init()
end

function StartState:enter()
    gSounds['intro']:stop()
    gSounds['intro']:setLooping(true)
    gSounds['intro']:setVolume(0.2)
    gSounds['intro']:play()

    self.backgroundTile = gTextures['tile-chess']

    self.offsetX = 0
    self.horizontalTilesCount = math.ceil(VIRTUAL_WIDTH / self.backgroundTile:getWidth()) + 1
    self.verticalTilesCount = math.ceil(VIRTUAL_HEIGHT / self.backgroundTile:getHeight())

    self.vehicles = {}
    Timer.every(0.5, function()
        if self.startGameLabel.alpha == 0 then
            self.startGameLabel.alpha = 255
        else
            self.startGameLabel.alpha = 0
        end
    end)

    Timer.every(2, function()
        table.insert(self.vehicles, self:generateVehicle())
    end)

    self.appTitleLabel = Label(math.floor((VIRTUAL_WIDTH - 200) / 2), 20, 200, 100,
        APP_TITLE, gFonts['xxlarge-inv'], { 255, 255, 255 }, 'center', 'center')

    self.startGameLabel = Label(math.floor((VIRTUAL_WIDTH - 250) / 2), 150, 250, 20,
        "Press 'Space' to start the game", gFonts['medium'], { 255, 255, 255 }, 'center', 'center')
end

function StartState:generateVehicle()
    local frame = math.random(1, 8) * 2

    local gridY = math.floor(math.random(0, VIRTUAL_HEIGHT - 24) / 24)

    local vehicle = Vehicle(VIRTUAL_WIDTH + 32, gridY * 24, 32, 24,
        nil, nil,
        math.random(-30, -10), 
        "cars", { frame - 1, frame }, { 255, 255, 255 })

    return vehicle
end

function StartState:exit()
    gSounds['intro']:stop()
    gSounds['confirm']:stop()
end

function StartState:update(dt)
    self.offsetX = math.floor(self.offsetX + BACKGROUND_SCROLL_SPEED * dt)
    if self.offsetX <= -self.backgroundTile:getWidth() then
        self.offsetX = 0
    end

    for i, vehicle in pairs(self.vehicles) do
        vehicle.x = vehicle.x + vehicle.speed * dt
        if vehicle.x < -vehicle.width then
            table.remove(self.vehicles, i)
        end
    end

    if love.keyboard.wasPressed('space') then
        gSounds['confirm']:stop()
        gSounds['confirm']:play()

        gStateStack:push(FadeInState({ 0, 0, 0 }, 1, function()
            -- pop fade in state
            gStateStack:pop()
            -- pop start state
            gStateStack:pop()

            gStateStack:push(BeginLevelState(1))
        end))
    end
end

function StartState:render()
    love.graphics.clear(0, 0, 0, 1)
    love.graphics.setColor(139/255, 172/255, 15/255, 0.6)

    for i=1,self.verticalTilesCount do
        for j=1,self.horizontalTilesCount do
            love.graphics.draw(self.backgroundTile, 
                (j - 1) * self.backgroundTile:getWidth() + self.offsetX, (i - 1) * self.backgroundTile:getHeight())
        end
    end

    love.graphics.setColor(1, 1, 1, 1)
    for i, vehicle in pairs(self.vehicles) do
        vehicle:render()
    end

    self.appTitleLabel:render()
    self.startGameLabel:render()

    -- reset color back to normal
    love.graphics.setColor(1, 1, 1, 1)
end
