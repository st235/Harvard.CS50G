TemplateMatcher = Class{__includes = View}

function TemplateMatcher:init(x, y, width, height,
                    template, font, textGravity,
                    templateColor, matchColor, errorColor,
                    paddingTop, paddingLeft,
                    paddingBottom, paddingRight)
    assert(#template > 0)
    
    View.init(self, x, y, width, height, paddingTop, paddingLeft, paddingBottom, paddingRight)

    self.font = font
    self.templateColor = templateColor or { 255, 255, 255 }
    self.matchColor = matchColor or { 0, 255, 0 }
    self.errorColor = errorColor or { 255, 0, 0 }

    assert(#self.templateColor == 3)
    assert(#self.matchColor == 3)
    assert(#self.errorColor == 3)

    self.textGravity = textGravity or 'left'

    local _, wrappedText = font:getWrap(template, self:getAdjustedWidth())

    self.templateLength = 0
    self.templateChunks = {}
    self.templateChunksWidths = {}

    for _, rawChunk in ipairs(wrappedText) do
        -- trim rows in case there are leading or trailing spaces
        -- that are invisible during typing
        local chunk = string.trim(rawChunk)

        self.templateLength = self.templateLength + #chunk

        table.insert(self.templateChunks, chunk)
        table.insert(self.templateChunksWidths, self.font:getWidth(chunk))
    end

    self.matchedTemplateChunk = 1
    self.matchedChunkSymbol = 1
    
    self.errorLength = 0

    -- keeping track of all symbols that matched
    self.matchedOverall = 0

    self.onMatch = function(s, p) end
    self.onError = function(s, p) end
    self.onErrorLimitExceed = function() end
end

function TemplateMatcher:remove()
    self.errorLength = math.max(0, self.errorLength - 1)
end

function TemplateMatcher:isMatched()
    return self.matchedTemplateChunk > #self.templateChunks
end

function TemplateMatcher:match(symbol)
    assert(not self:isMatched())

    local templateSymbol = self.templateChunks[self.matchedTemplateChunk]:sub(self.matchedChunkSymbol, self.matchedChunkSymbol)

    if templateSymbol ~= symbol then
        return false
    end

    return true
end

function TemplateMatcher:getMatchedSymbolsCount()
    return self.matchedOverall
end

function TemplateMatcher:getSymbolsCount()
    return self.templateLength
end

function TemplateMatcher:update()
    while not self:isMatched() and love.keyboard.hasPendingSymbols() do
        local symbol = love.keyboard.consumePendingSymbol()
        
        if self:match(symbol) and self.errorLength == 0 then
            self.matchedOverall = self.matchedOverall + 1
            self.matchedChunkSymbol = self.matchedChunkSymbol + 1

            if self.matchedChunkSymbol > #self.templateChunks[self.matchedTemplateChunk] then
                self.matchedTemplateChunk = self.matchedTemplateChunk + 1
                self.matchedChunkSymbol = 1
            end

            -- triggering match callback
            self.onMatch(s, self.matchedOverall / self.templateLength)
        else
            if self.errorLength == MAXIMUM_ERROR_ACCUMULATION_LENGTH then
                -- errorLength is already at maximum accumulation limit
                self.onErrorLimitExceed()
            end

            self.errorLength = math.min(MAXIMUM_ERROR_ACCUMULATION_LENGTH, self.errorLength + 1)

            -- triggering error callback
            self.onError(s, self.matchedOverall / self.templateLength)
        end
    end

    if love.keyboard.wasPressed('backspace') then
        self:remove()
    end
end

function TemplateMatcher:render()
    View.render(self)

    local currentX = self.x + self.paddingLeft
    local currentY = self.y + self.paddingTop

    local textHeight = self.font:getHeight()
    local adjustedWidth = self:getAdjustedWidth()

    local errorLength = self.errorLength

    for i, chunk in ipairs(self.templateChunks) do
        local offsetX = 0
        local chunkWidth = self.templateChunksWidths[i]

        if self.textGravity == 'left' then
            offsetX = 0
        elseif self.textGravity == 'center' then
            offsetX = math.floor((adjustedWidth - chunkWidth) / 2)
        else
            offsetX = math.floor(adjustedWidth - chunkWidth)
        end

        if i < self.matchedTemplateChunk then
            -- the entire line is a match
            love.graphics.setColor(self.matchColor[1] / 255, self.matchColor[2] / 255, self.matchColor[3] / 255, 1)
            love.graphics.rectangle('fill', currentX + offsetX, currentY, chunkWidth, textHeight)
        elseif i == self.matchedTemplateChunk then
            local matchWidth = self.font:getWidth(chunk:sub(1, self.matchedChunkSymbol - 1))

            love.graphics.setColor(self.matchColor[1] / 255, self.matchColor[2] / 255, self.matchColor[3] / 255, 1)
            love.graphics.rectangle('fill', currentX + offsetX, currentY, matchWidth, textHeight)

            if errorLength > 0 then
                local currentErrorLength = math.min(errorLength, #chunk - self.matchedChunkSymbol + 1)
                local errorWidth = self.font:getWidth(chunk:sub(self.matchedChunkSymbol, self.matchedChunkSymbol + currentErrorLength - 1))
                errorLength = errorLength - currentErrorLength

                love.graphics.setColor(self.errorColor[1] / 255, self.errorColor[2] / 255, self.errorColor[3] / 255, 1)
                love.graphics.rectangle('fill', currentX + offsetX + matchWidth, currentY, errorWidth, textHeight)
            end
        elseif i > self.matchedTemplateChunk and errorLength > 0 then
            local currentErrorLength = math.min(errorLength, #chunk)
            local errorWidth = self.font:getWidth(chunk:sub(1, currentErrorLength))
            errorLength = errorLength - currentErrorLength

            love.graphics.setColor(self.errorColor[1] / 255, self.errorColor[2] / 255, self.errorColor[3] / 255, 1)
            love.graphics.rectangle('fill', currentX + offsetX, currentY, errorWidth, textHeight)
        end

        love.graphics.setColor(self.templateColor[1] / 255, self.templateColor[2] / 255, self.templateColor[3] / 255, 1)
        love.graphics.print(chunk, self.font, currentX + offsetX, currentY)
        
        currentY = currentY + textHeight
    end

    love.graphics.setColor(1, 1, 1, 1)
end
