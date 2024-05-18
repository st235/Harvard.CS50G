function updateEntityWithinRoom(dt, entity, collideableObjects)
    local bumped = false

    local dx = 0
    local dy = 0

    -- boundary checking on all sides, allowing us to avoid collision detection on tiles
    if entity.direction == 'left' then
        dx = -entity.walkSpeed * dt
        entity.x = entity.x + dx
        
        if entity.x <= MAP_RENDER_OFFSET_X + TILE_SIZE then 
            entity.x = MAP_RENDER_OFFSET_X + TILE_SIZE
            bumped = true
        end
    elseif entity.direction == 'right' then
        dx = entity.walkSpeed * dt
        entity.x = entity.x + dx

        if entity.x + entity.width >= VIRTUAL_WIDTH - TILE_SIZE * 2 then
            entity.x = VIRTUAL_WIDTH - TILE_SIZE * 2 - entity.width
            bumped = true
        end
    elseif entity.direction == 'up' then
        dy = -entity.walkSpeed * dt
        entity.y = entity.y + dy

        if entity.y <= MAP_RENDER_OFFSET_Y + TILE_SIZE - entity.height / 2 then 
            entity.y = MAP_RENDER_OFFSET_Y + TILE_SIZE - entity.height / 2
            bumped = true
        end
    elseif entity.direction == 'down' then
        dy = entity.walkSpeed * dt
        entity.y = entity.y + dy

        local bottomEdge = VIRTUAL_HEIGHT - (VIRTUAL_HEIGHT - MAP_HEIGHT * TILE_SIZE) 
            + MAP_RENDER_OFFSET_Y - TILE_SIZE

        if entity.y + entity.height >= bottomEdge then
            entity.y = bottomEdge - entity.height
            bumped = true
        end
    end

    for k, object in pairs(collideableObjects) do
        if object.solid and entity:collides(object) then
            bumped = true

            entity.x = entity.x - dx
            entity.y = entity.y - dy
        end
    end

    return bumped
end
