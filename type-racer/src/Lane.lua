Lane = Class{}

function Lane:init(x, y, width, height, driverId, vehicle)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.driverId = string.format("%02d", driverId)

    self.progress = 0
    self.offsetX = 32

    local labelWidth = 16
    local labelHeight = 16
    self.label = Label(
        math.floor(self.x + (self.offsetX - labelWidth) / 2), math.floor(self.y + (self.height - labelHeight) / 2),
        labelWidth, labelHeight, self.driverId, gFonts['small'], { 255, 255, 255 }, 'center')

    self.vehicle = vehicle
    self.vehicle.x = self.x + (1 - self.progress) * (self.width - self.vehicle.width)
    self.vehicle.y = self.y + (self.height - self.vehicle.height)

    self.onFinish = function(id) end

    self.tweeningTask = nil
end

function Lane:setProgress(newProgress, time)
    assert(newProgress >= 0 and newProgress <= 1)

    self.progress = newProgress

    if self.tweeningTask ~= nil then
        self.tweeningTask:remove()
    end

    self.tweeningTask = Timer.tween(time, {
        [self.vehicle] = { x = self.x + self.offsetX + (1 - self.progress) * (self.width - self.vehicle.width - self.offsetX) }
    }):finish(function()
        if self.progress == 1 then
            self:finish(driverId)
        end
    end)
end

function Lane:finish(driverId)
    self.label.color = { 15, 56, 15 }
    self.label:setBackground(Circle({232, 246, 211}))
    self.onFinish(self.driverId)
end

function Lane:update(dt)
    self.vehicle:update(dt)
end

function Lane:render()
    -- code for debugging the boundaries of the lane
    -- love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(0, 0, 1, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.offsetX, self.height)

    self.label:render()

    self.vehicle:render()
end