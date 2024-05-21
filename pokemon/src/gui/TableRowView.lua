TableRowView = Class{}

function TableRowView:init(x, y, columnTexts, columnWidths, columnColors, columnGravities, columnSpacing)
    assert(#columnTexts == #columnWidths)
    assert(#columnTexts == #columnColors)
    assert(#columnTexts == #columnGravities)

    self.x = x
    self.y = y

    self.height = 0
    self.width = (#columnWidths - 1) * columnSpacing
    for i, text in pairs(columnTexts) do
        self.height = math.max(self.height, text:getHeight())
        self.width = self.width + columnWidths[i]
    end

    self.columnTexts = columnTexts
    self.columnWidths = columnWidths
    self.columnColors = columnColors
    self.columnGravities = columnGravities

    self.columnSpacing = columnSpacing
end

function TableRowView:update(dt)
end

function TableRowView:render()
    -- debug code
    -- uncomment to see row bounds
    -- love.graphics.setColor(1, 0, 0, 1)
    -- love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    local left = self.x
    local top = self.y

    for i = 1, #self.columnTexts do
        local columnWidth = self.columnWidths[i]
        local columnText = self.columnTexts[i]
        local columnColor = self.columnColors[i]
        local columnGravity = self.columnGravities[i]

        local textWidth, textHeight = columnText:getDimensions()

        assert(#columnColor == 3)

        love.graphics.setColor(columnColor[1] / 255, columnColor[2] / 255, columnColor[3] / 255, 1)

        if columnGravity == 'left' then
            love.graphics.draw(columnText, left, math.floor(top + (self.height - textHeight) / 2))
        elseif columnGravity == 'center' then
            love.graphics.draw(columnText, left + math.floor((columnWidth - textWidth) / 2), math.floor(top + (self.height - textHeight) / 2))
        elseif columnGravity == 'right' then
            love.graphics.draw(columnText, left + (columnWidth - textWidth), math.floor(top + (self.height - textHeight) / 2))
        end

        left = left + columnWidth + self.columnSpacing
    end

    -- reset color
    love.graphics.setColor(1, 1, 1, 1)
end