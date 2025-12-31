local IntPairSet = require("IntPairSet")
local Dump = require("Dump")
_G.love = require("love")
_G.initialPoints = {
    {300, 0},
    {0, 520},
    {600, 520}
}
_G.points = IntPairSet.new()
_G.points:add(300, 0)
_G.points:add(0, 520)
_G.points:add(600, 520)
_G.currentPoint = {300,260}
_G.width = 600
_G.height = 520

local palette = {
    {1, 0.2, 0.2}, -- Reddish
    {0.2, 1, 0.2}, -- Greenish
    {0.2, 0.6, 1}  -- Bluish
}

local colorLists = {{}, {}, {}}

local function round(n)
    return math.floor(n + 0.5)
end

local function midpoint(a, b)
    -- Return integer coordinates so the Set can track unique pixels
    return {
        round((a[1] + b[1]) / 2),
        round((a[2] + b[2]) / 2)
    }
end

function _G.love.load()
    math.randomseed(os.time())
    love.graphics.setPointSize(1) -- Try 2 for a bolder look
end

function _G.love.update(dt)
    -- Increase this number for faster fractal generation
    for i = 1, 200 do 
        local rIndex = math.random(1, #_G.initialPoints)
        local target = _G.initialPoints[rIndex]
        
        _G.currentPoint = midpoint(_G.currentPoint, target)
        
        -- The Set ensures we only store and draw a pixel once
        if _G.points:add(_G.currentPoint[1], _G.currentPoint[2]) then
            -- We add the offset directly here so the draw loop is "free"
            table.insert(colorLists[rIndex], _G.currentPoint[1] + 25)
            table.insert(colorLists[rIndex], _G.currentPoint[2] + 25)
        end
    end
end

function _G.love.draw()
    -- Set the background to dark so the colors pop
    -- love.graphics.clear(0.05, 0.05, 0.05) 

    for i = 1, 3 do
        love.graphics.setColor(palette[i])
        -- This is high performance because it's only 3 draw calls total
        love.graphics.points(colorLists[i])
    end
end