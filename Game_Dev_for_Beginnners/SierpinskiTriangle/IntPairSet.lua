local IntPairSet = {}
IntPairSet.__index = IntPairSet

function IntPairSet.new()
    return setmetatable({ items = {} }, IntPairSet)
end

function IntPairSet:add(x, y)
    -- Create a unique string key, e.g., "1,2"
    local key = x .. "," .. y
    if not self.items[key] then
        self.items[key] = {x, y}
        return true -- Successfully added
    end
    return false -- Already exists
end

function IntPairSet:has(x, y)
    return self.items[x .. "," .. y] ~= nil
end

function IntPairSet:iterate(callback)
    for _, coords in pairs(self.items) do
        callback(coords[1], coords[2])
    end
end

function IntPairSet:getFlatCoordinates(offsetX, offsetY)
    offsetX = offsetX or 0
    offsetY = offsetY or 0
    local temp = {}
    
    -- 1. Gather points
    for _, val in pairs(self.items) do
        table.insert(temp, {x = val[1], y = val[2]})
    end

    -- 2. Sort (ensures consistent rendering/order)
    table.sort(temp, function(a, b)
        if a.x == b.x then return a.y < b.y end
        return a.x < b.x
    end)

    -- 3. Flatten
    local flat = {}
    for _, pos in ipairs(temp) do
        table.insert(flat, pos.x + offsetX)
        table.insert(flat, pos.y + offsetY)
    end

    return flat
end

return IntPairSet