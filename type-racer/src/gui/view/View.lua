View = Class{}

function View:init(x, y, width, height,
                   paddingTop, paddingLeft,
                   paddingBottom, paddingRight)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.paddingTop = paddingTop or 0
    self.paddingLeft = paddingLeft or 0
    self.paddingBottom = paddingBottom or 0
    self.paddingRight = paddingRight or 0

    self.isVisible = true
    self.isDebug = false

    self.background = nil
end

function View:setBackground(background)
    self.background = background
end

function View:getAdjustedWidth()
    return self.width - self.paddingLeft - self.paddingRight
end

function View:getAdjustedHeight()
    return self.height - self.paddingTop - self.paddingBottom
end

function View:setDebug(isDebug)
    self.isDebug = isDebug
end

function View:setVisibility(isVisible)
    self.isVisible = isVisible
end

function View:update(dt)
end

function View:render()
    if self.isVisible then
        if self.isDebug then
            love.graphics.setColor(1, 0, 0, 1)    
            love.graphics.rectangle('line', self.x, self.y, self.width, self.height)
        end

        if self.background ~= nil then
            self.background:draw(self.x, self.y, self.width, self.height)
        end

        -- reset color to normal
        love.graphics.setColor(1, 1, 1, 1)
    end
end
