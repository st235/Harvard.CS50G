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
end

function TileMap:generateGround()
    self.groundTiles = {}

    local currentGrassSkin = GROUND_GRASS_TILES[math.random(#GROUND_GRASS_TILES)]
    local currentPavementSkin = GROUND_PAVEMENT_TILES[math.random(#GROUND_PAVEMENT_TILES)]

    local grassHeight = math.min(GROUND_GRASS_HEIGHT, self.tilesHeight)
    local pavementHeight = math.min(grassHeight + GROUND_PAVEMENT_HEIGHT, self.tilesHeight)

    -- grass
    for i=1, grassHeight do
        table.insert(self.groundTiles, {})
        for j=1, self.tilesWidth do
            local x = (j - 1) * GROUND_TILE_SIZE
            local y = (i - 1) * GROUND_TILE_SIZE
            table.insert(self.groundTiles[i], Tile(x, y, GROUND_TILE_SIZE, GROUND_TILE_SIZE, 'ground', currentGrassSkin))
        end
    end

    -- pavement
    for i=grassHeight + 1, pavementHeight do
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
    for i=pavementHeight, self.tilesHeight do
        table.insert(self.groundTiles, {})
        for j=1, self.tilesWidth do
            local x = (j - 1) * GROUND_TILE_SIZE
            local y = (i - 1) * GROUND_TILE_SIZE
            table.insert(self.groundTiles[i], Tile(x, y, GROUND_TILE_SIZE, GROUND_TILE_SIZE, 'ground', GROUND_TILE_ROAD))
        end
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
end
