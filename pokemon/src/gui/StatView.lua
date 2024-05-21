StatView = Class{}

function StatView.createTable(statItems)
    local columns = { 'title', 'valueDiff', 'valueAfter' }
    local statTable = {}

    for i, statItem in ipairs(statItems) do
        table.insert(statTable, { 
            statItem['title'],
            tostring(statItem['valueAfter'] - statItem['valueDiff']),
            "+ " .. tostring(statItem['valueDiff']),
            "= " .. tostring(statItem['valueAfter'])
        })
    end

    return statTable
end

function StatView:init(x, y, width, height, message, headers, statItems)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.message = love.graphics.newText(gFonts['small'], message)

    self.headerColor = { 255, 255, 255 }
    self.valuesColor = { 229, 228, 226 }
    self.diffColor = { 159, 226, 191 }
    self.resultColor = { 255, 255, 143 }

    self.headers = headers
    self.headerColors = {
        self.headerColor,
        self.headerColor,
        self.headerColor,
        self.headerColor
    }
    self.headerGravities = {
        'left',
        'center',
        'center',
        'center'
    }

    self.items = StatView.createTable(statItems)
    self.columnColors = {
        self.headerColor,
        self.valuesColor,
        self.diffColor,
        self.resultColor
    }
    self.columnGravities = {
        'left',
        'center',
        'center',
        'center'
    }

    self.paddingTop = 3
    self.paddingBottom = 3
    self.paddingLeft = 6
    self.paddingRight = 6
    
    self.panel = Panel(x, y, width, height)
    self.table = TableView(x + self.paddingLeft, y + self.paddingTop + self.message:getHeight() + 4, 
        width - self.paddingLeft - self.paddingRight, height - self.paddingTop - self.paddingBottom - self.message:getHeight() - 4,
        self.headers, self.items, 
        gFonts['small'], gFonts['small'],
        self.headerColors, self.columnColors,
        self.headerGravities, self.columnGravities)
end

function StatView:update(dt)
    self.table:update(dt)
end

function StatView:isClosed()
    return self.table:isClosed()
end

function StatView:render()
    self.panel:render()

    love.graphics.draw(self.message, self.x + self.paddingLeft, self.y + self.paddingTop)
    self.table:render()
end
