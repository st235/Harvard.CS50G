Tile = Class{}

function Tile:init(x, y, width, height, texture, frame)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.texture = texture
    self.frame = frame
end

function Tile:update(dt)
end

function Tile:render()
    love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame], self.x, self.y)
end
