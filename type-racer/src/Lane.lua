Lane = Class{}

function Lane:init(x, y, width, height, vehicle)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.progress = 0

    self.vehicle = vehicle
    self.vehicle.y = self.y + (self.height - self.vehicle.height)
    self.vehicle.x = self.x + (1 - self.progress) * (self.width - self.vehicle.width)

    self.onFinish = function() end

    self.tweeningTask = nil
end

function Lane:appendProgress(diffProgress)
    self:setProgress(math.max(0, math.min(1, self.progress + diffProgress)))
end

function Lane:setProgress(newProgress)
    assert(newProgress >= 0 and newProgress <= 1)

    self.progress = newProgress

    if self.tweeningTask ~= nil then
        self.tweeningTask:remove()
    end

    self.tweeningTask = Timer.tween(0.4, {
        [self.vehicle] = { x = self.x + (1 - self.progress) * (self.width - self.vehicle.width) }
    })

    if self.progress == 1 then
        self.onFinish()
    end
end

function Lane:update(dt)
    self.vehicle:update(dt)
end

function Lane:render()
    -- code for debugging the boundaries of the lane
    -- love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    self.vehicle:render()
end
