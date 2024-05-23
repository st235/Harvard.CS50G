TileMap = Class{}

function TileMap:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.tilesWidth = math.floor(width / GROUND_TILE_SIZE)
    if width % GROUND_TILE_SIZE > 0 then
        self.tilesWidth = self.tilesWidth + 1
    end

    self.tilesHeight = math.floor(height / GROUND_TILE_SIZE)
    if height % GROUND_TILE_SIZE > 0 then
        self.tilesHeight = self.tilesHeight + 1
    end

    self:generateGround()
    self:generateBuildings()
end

function TileMap:generateGround()
    self.groundTiles = {}

    local currentGrassSkin = GROUND_GRASS_TILES[math.random(#GROUND_GRASS_TILES)]
    local currentPavementSkin = GROUND_PAVEMENT_TILES[math.random(#GROUND_PAVEMENT_TILES)]

    local grassTilesHeight = GROUND_GRASS_HEIGHT
    local pavementTilesHeight = grassTilesHeight + GROUND_PAVEMENT_HEIGHT

    -- grass
    for i=1, grassTilesHeight do
        table.insert(self.groundTiles, {})
        for j=1, self.tilesWidth do
            local x = (j - 1) * GROUND_TILE_SIZE
            local y = (i - 1) * GROUND_TILE_SIZE
            table.insert(self.groundTiles[i], Tile(x, y, GROUND_TILE_SIZE, GROUND_TILE_SIZE, 'ground', currentGrassSkin))
        end
    end

    -- pavement
    for i=grassTilesHeight + 1, pavementTilesHeight do
        table.insert(self.groundTiles, {})
        for j=1, self.tilesWidth do
            local x = (j - 1) * GROUND_TILE_SIZE
            local y = (i - 1) * GROUND_TILE_SIZE

            local skin = currentPavementSkin
            if math.random(100) <= 3 then
                skin = GROUND_TILE_FLOWER
            end

            table.insert(self.groundTiles[i], Tile(x, y, GROUND_TILE_SIZE, GROUND_TILE_SIZE, 'ground', skin))
        end
    end

    -- road
    for i=pavementTilesHeight, self.tilesHeight do
        table.insert(self.groundTiles, {})
        for j=1, self.tilesWidth do
            local x = (j - 1) * GROUND_TILE_SIZE
            local y = (i - 1) * GROUND_TILE_SIZE
            table.insert(self.groundTiles[i], Tile(x, y, GROUND_TILE_SIZE, GROUND_TILE_SIZE, 'ground', GROUND_TILE_ROAD))
        end
    end
end

function TileMap:generateBuildings()
    self.buildings = {}

    local grassHeightPx = GROUND_GRASS_HEIGHT * GROUND_TILE_SIZE

    local currentX = self.x
    while currentX <= self.x + self.width do
        local buildingId = math.random(#BUILDING_SIZES)

        local buildingSize = BUILDING_SIZES[buildingId]
        local offsetY = self.y + grassHeightPx - buildingSize.height

        table.insert(self.buildings, Tile(currentX, offsetY, buildingSize.width, buildingSize.height, 'buildings', buildingId))

        currentX = currentX + buildingSize.width
    end
end

function TileMap:update(dt)
end

function TileMap:render()
    for i=1, self.tilesHeight do
        for j=1, self.tilesWidth do
            self.groundTiles[i][j]:render()
        end
    end

    for i=1, #self.buildings do
        self.buildings[i]:render()
    end
end
