local IntPairSet = require("IntPairSet")
local Dump = require("Dump")
_G.love = require("love")
local initialPoints = {
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
    {1, 0, 0},
    {0, 1, 0},
    {0, 0, 1}
}

local colorLists = {{}, {}, {}}

local function round(n)
    return math.floor(n + 0.5)
end

local function midpoint(a, b)
    return {
        round((a[1] + b[1]) / 2),
        round((a[2] + b[2]) / 2)
    }
end

function love.load()
    math.randomseed(os.time())
    love.graphics.setPointSize(1)
end

function love.update(dt)
    for _ = 1, 200 do
        local rIndex = math.random(1, #initialPoints)
        local target = initialPoints[rIndex]
        currentPoint = midpoint(currentPoint, target)
        if points:add(currentPoint[1], currentPoint[2]) then
            table.insert(colorLists[rIndex], currentPoint[1] + 25)
            table.insert(colorLists[rIndex], currentPoint[2] + 25)
        end
    end
end

function love.draw()
    love.graphics.clear(0.05, 0.05, 0.05)
    for i = 1, 3 do
        love.graphics.setColor(palette[i])
        love.graphics.points(colorLists[i])
    end
end