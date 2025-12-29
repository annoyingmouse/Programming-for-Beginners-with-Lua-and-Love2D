local Dump = require("Dump")
local MAX_NUMBER = 99
local MIN_NUMBER = 0
local RANGE_SIZE = MAX_NUMBER - MIN_NUMBER + 1
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

local input_lines = read_file("input.txt")

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
