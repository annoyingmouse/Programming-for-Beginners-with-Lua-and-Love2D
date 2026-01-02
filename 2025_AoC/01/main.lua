local Dump = require("Dump")
-- _G.love = require("love")

local MAX_NUMBER = 99
local MIN_NUMBER = 0
local currentNumber = 50
local zeroHitCount1 = 0
local zeroHitCount2 = 0

local function read_file(path)
    local file = io.open(path, "rb")
    if not file then return nil end
    local lines = {}
    for line in io.lines(path) do
      table.insert(lines, line)
    end
    file:close()
    return lines
end

local input_lines = read_file("test.txt")

-- function love.load()
--   _G.centerX = love.graphics.getWidth() / 2
--   _G.centerY = love.graphics.getHeight() / 2
--   _G.radius = 200
-- end

-- function love.draw()
--   print('input_lines:', #input_lines)
--   love.graphics.clear(0.1, 0.1, 0.1)
--   love.graphics.setColor(1, 1, 1)

--   for i = MIN_NUMBER, MAX_NUMBER do
--     local angle = (i / (MAX_NUMBER - MIN_NUMBER + 1)) * (2 * math.pi) - (math.pi / 2)
--     local x = _G.centerX + math.cos(angle) * _G.radius
--     local y = _G.centerY + math.sin(angle) * _G.radius
--     love.graphics.line(_G.centerX, _G.centerY, x, y)
--   end
-- end


if input_lines then
  for _, value in ipairs(input_lines) do
    local letter, number = string.match(value, "([A-Z]+)(%d+)")
    number = tonumber(number)
    local stepDirection = (letter == "L") and -1 or 1
    for _ = 1, number do
      currentNumber = currentNumber + stepDirection
      if currentNumber < MIN_NUMBER then
        currentNumber = MAX_NUMBER
      elseif currentNumber > MAX_NUMBER then
        currentNumber = MIN_NUMBER
      end
      if currentNumber == 0 then
        zeroHitCount2 = zeroHitCount2 + 1
      end
    end
    if currentNumber == 0 then
      zeroHitCount1 = zeroHitCount1 + 1
    end
  end
end

print("Part 1: Number of times 0 was hit: " .. zeroHitCount1)
print("Part 2: Number of times 0 was hit: " .. zeroHitCount2)
