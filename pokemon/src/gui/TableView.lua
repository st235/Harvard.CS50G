TableView = Class{}

function TableView.createTextTable(font, rawTable)
    local textTable = {}

    for i, row in ipairs(rawTable) do
        table.insert(textTable, {})

        for _, item in ipairs(row) do            
            table.insert(textTable[i], love.graphics.newText(font, item))
        end
    end

    return textTable
end

function TableView.findMaxColumnWidths(headerTexts, rawTable)
    local columnWidths = {}

    for j, header in ipairs(headerTexts) do
        if j > #columnWidths then
            table.insert(columnWidths, 0)
        end

        columnWidths[j] = math.max(columnWidths[j], headerTexts[j]:getWidth())
    end

    for _, row in ipairs(rawTable) do
        for j, item in ipairs(row) do            
            columnWidths[j] = math.max(columnWidths[j], item:getWidth())
        end
    end

    return columnWidths
end

function TableView:init(x, y, width, height, 
                        headers, items, 
                        fontHeader, fontContent,
                        headerColors, columnColors,
                        headerGravities, columnGravities)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    self.paddingTop = 0
    self.paddingBottom = 0
    self.paddingLeft = 0

    self.fontHeader = fontHeader or gFonts['small']
    self.fontContent = fontContent or gFonts['small']

    self.rowSpacing = 4
    self.columnSpacing = 8

    self.items = TableView.createTextTable(fontContent, items)

    self.headerTexts = {}
    self.headerColors = {}
    self.headerGravities = {}

    for i, header in ipairs(headers) do
        table.insert(self.headerTexts, love.graphics.newText(fontHeader, header))
        table.insert(self.headerColors, headerColors[i])
        table.insert(self.headerGravities, headerGravities[i])
    end
    assert(#self.headerTexts == #self.headerColors)

    self.columnWidths = TableView.findMaxColumnWidths(self.headerTexts, self.items)
    self.columnColors = columnColors
    self.columnGravities = columnGravities

    self.currentRowIndex = 1
    self.displayRows = {}

    self:next()
end

function TableView:next()
    self.displayRows = {}

    local currentX = self.x + self.paddingLeft
    local currentY = self.y + self.paddingTop

    local headerRow = TableRowView(currentX, currentY, 
        self.headerTexts, self.columnWidths,
        self.headerColors, self.headerGravities,
        self.columnSpacing)
    table.insert(self.displayRows, headerRow)

    currentY = currentY + headerRow.height + self.rowSpacing
    if self.currentRowIndex > #self.items then
        return
    end

    local adjustedHeight = self.height - self.paddingTop - self.paddingBottom

    local nextRow = TableRowView(currentX, currentY, 
        self.items[self.currentRowIndex], self.columnWidths, 
        self.columnColors, self.columnGravities,
        self.columnSpacing)

    while self.currentRowIndex <= #self.items and 
        (currentY - self.y + nextRow.height <= adjustedHeight) do
        currentY = currentY + nextRow.height + self.rowSpacing
        self.currentRowIndex = self.currentRowIndex + 1

        table.insert(self.displayRows, nextRow)

        if self.currentRowIndex <= #self.items then
            nextRow = TableRowView(currentX, currentY, 
                self.items[self.currentRowIndex], self.columnWidths, 
                self.columnColors, self.columnGravities,
                self.columnSpacing)
        else
            nextRow = nil
        end
    end
end

function TableView:update(dt)
    if love.keyboard.wasPressed('space') or love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        self:next()
    end
end

function TableView:isClosed()
    -- there is always header item in the table
    return #self.displayRows == 1
end

function TableView:render()    
    for i = 1, #self.displayRows do
        local row = self.displayRows[i]
        row:render()
    end
end
