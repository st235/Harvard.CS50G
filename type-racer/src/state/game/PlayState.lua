PlayState = Class{__includes = BaseState}

function PlayState:init()
end

function PlayState:enter(params)
    self.tileMap = TileMap(0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)

    local panelWidth = 200
    local panelHeight = 90
    local panelX = math.floor((VIRTUAL_WIDTH - panelWidth) / 2)
    local panelY = 10
    local panelVerticalPadding = 6
    local panelHorinzontalPadding = 8

    self.panel = Panel(panelX, panelY, panelWidth, panelHeight)
    self.matcher = TemplateMatcher(panelX + panelHorinzontalPadding, panelY + panelVerticalPadding, 
        panelWidth - 2 * panelHorinzontalPadding, panelHeight - 2 * panelVerticalPadding, 
        'Hello world! This is a check for typing test blha-blha hahaha', gFonts['small'])
    
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

    self.tileMap:render()
    self.panel:render()
    self.matcher:render()
    self.race:render()
end
