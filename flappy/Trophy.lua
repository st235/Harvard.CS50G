local TROPHY_IMAGE_BRONZE = love.graphics.newImage('coin_bronze.png')
local TROPHY_IMAGE_SILVER = love.graphics.newImage('coin_silver.png')
local TROPHY_IMAGE_GOLD = love.graphics.newImage('coin_gold.png')

local TROPHY_THRESHOLD_BRONZE = 3
local TROPHY_THRESHOLD_SILVER = 5
local TROPHY_THRESHOLD_GOLD = 10

local TROPHY_ICONS = {
    ['bronze'] = TROPHY_IMAGE_BRONZE,
    ['silver'] = TROPHY_IMAGE_SILVER,
    ['gold'] = TROPHY_IMAGE_GOLD
}

Trophy = Class{}

function Trophy:init(trophyType)
    self.image = TROPHY_ICONS[trophyType]

    self.size = 0
    if self.image then
        assert(self.image:getWidth() == self.image:getHeight())
        self.size = self.image:getWidth()
    end
end

function Trophy:getSize()
    if self.size == 0 then
        assert(self.image == nil)
    end

    return self.size
end

function Trophy:draw(x, y)
    if self.image then
        love.graphics.draw(self.image, x, y)
    end
end

function Trophy.create(score)
    local trophyType = 'no'

    if score >= TROPHY_THRESHOLD_GOLD then
        trophyType = 'gold'
    elseif score >= TROPHY_THRESHOLD_SILVER then
        trophyType = 'silver'
    elseif score >= TROPHY_THRESHOLD_BRONZE then
        trophyType = 'bronze'
    end

    return Trophy(trophyType)
end
