LevelUpStatsState = Class{__includes = BaseState}

function LevelUpStatsState:init(stats, onClose)
    local headers = { "", "Previous Level", "Upgrade", "New Level" }

    local statItems = {
        { 
            ['title'] = 'HP',
            ['valueDiff'] = stats['hpIncrease'],
            ['valueAfter'] = stats['hp']
        },
        { 
            ['title'] = 'Speed',
            ['valueDiff'] = stats['speedIncrease'],
            ['valueAfter'] = stats['speed']
        },
        { 
            ['title'] = 'Attack',
            ['valueDiff'] = stats['attackIncrease'],
            ['valueAfter'] = stats['attack']
        },
        { 
            ['title'] = 'Defense',
            ['valueDiff'] = stats['defenseIncrease'],
            ['valueAfter'] = stats['defense']
        }
    }

    self.statView = StatView(0, VIRTUAL_HEIGHT - 64, VIRTUAL_WIDTH, 64, 
        "Pokemon new level statistics:", headers, statItems)

    -- function to be called once this message is popped
    self.onClose = onClose or function() end
end

function LevelUpStatsState:update(dt)
    self.statView:update(dt)

    if self.statView:isClosed() then
        gStateStack:pop()
        self.onClose()
    end
end

function LevelUpStatsState:render()
    self.statView:render()
end