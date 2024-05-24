Icon = Class{__includes = View}

function Icon:init(x, y, width, height,
                   texture, frame,
                   paddingTop, paddingLeft,
                   paddingBottom, paddingRight)
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.texture = texture
    self.frame = frame

    local textureWidth = 0
    local textureHeight = 0

    if not self.frame then
        textureWidth = gTextures[self.texture]:getWidth()
        textureHeight = gTextures[self.texture]:getHeight()
    else
        local _, _, qw, qh = gFrames[self.texture][self.frame]:getViewport()
        
        textureWidth = qw
        textureHeight = qh
    end

    local scale = 1 

    if self:getAdjustedWidth() <= self:getAdjustedHeight() then
        scale = self:getAdjustedWidth() / textureWidth
    else
        scale = self:getAdjustedHeight() / textureHeight
    end

    self.scaleX = math.floor(scale)
    self.scaleY = math.floor(scale)

    self.actualTextureWidth = textureWidth * self.scaleX
    self.actualTextureHeight = textureWidth * self.scaleY
end

function Icon:update(dt)
end

function Icon:render()
    View.render(self)

    local offsetX = math.floor((self:getAdjustedWidth() - self.actualTextureWidth) / 2)
    local offsetY = math.floor((self:getAdjustedHeight() - self.actualTextureHeight) / 2)

    if not self.frame then
        love.graphics.draw(gTextures[self.texture],
            self.x + self.paddingLeft + offsetX, self.y + self.paddingTop + offsetY,
            0, self.scaleX, self.scaleY)
    else
        love.graphics.draw(gTextures[self.texture], gFrames[self.texture][self.frame],
        self.x + self.paddingLeft + offsetX, self.y + self.paddingTop + offsetY,
        0, self.scaleX, self.scaleY)
    end
end
