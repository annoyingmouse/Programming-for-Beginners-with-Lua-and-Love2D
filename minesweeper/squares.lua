local Square = {}
function Square:new(name, xMin, xMax, yMin, yMax, font)
  local obj = {
    name = name,
    xMin = xMin,
    xMax = xMax,
    yMin = yMin,
    yMax = yMax,
    visible = false,
    content = "",
    font = font,
    flagged = false,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

local colourMap = {
    ["#"] = {0.8, 0.8, 0.8},
    ["0"] = {0.4, 0.4, 0.4},
    ["1"] = {0, 0, 0.5},
    ["2"] = {0, 0, 1},
    ["3"] = {0, 1, 0},
    ["4"] = {1, 1, 0},
    ["5"] = {1, 0.5, 0},
    ["6"] = {1, 0, 0},
    ["7"] = {1, 0, 1},
    ["8"] = {1, 0.7, 0.7},
}

Square.getColour = function(self)
    if self.content == "#" then
        return {0.8, 0.8, 0.8}
    elseif self.content == "0" then
        return {0.4, 0.4, 0.4}
    elseif self.content == "1" then
        return {0, 0, 0.5}
    elseif self.content == "2" then
        return {0, 0, 1}
    elseif self.content == "3" then
        return {0, 1, 0}
    elseif self.content == "4" then
        return {1, 1, 0}
    elseif self.content == "5" then
        return {1, 0.5, 0}
    elseif self.content == "6" then
        return {1, 0, 0}
    elseif self.content == "7" then
        return {1, 0, 1}
    elseif self.content == "8" then
        return {1, 0.7, 0.7}
    else
        return {1, 1, 1}
    end
end

Square.draw = function(self)
    love.graphics.setFont(self.font)
    love.graphics.rectangle("line", self.xMin, self.yMin, self.xMax - self.xMin, self.yMax - self.yMin)
    if self.visible then
        love.graphics.setFont(self.font)
        love.graphics.setColor(colourMap[self.content] or {1, 1, 1}) -- Default to white if content not found
        love.graphics.printf(
            self.content,
            self.xMin,
            self.yMin + (self.yMax - self.yMin) / 2 - (self.font:getHeight() / 2), -- Vertical centering
            self.xMax - self.xMin,
            "center" -- Horizontal centering
        )
        love.graphics.setColor(1, 1, 1) -- Reset color to white
    end
    if self.flagged then
        love.graphics.setColor(1, 0, 0) -- Red color for flag
        love.graphics.printf(
            "F",
            self.xMin,
            self.yMin + (self.yMax - self.yMin) / 2 - (self.font:getHeight() / 2), -- Vertical centering
            self.xMax - self.xMin,
            "center" -- Horizontal centering
        )
        love.graphics.setColor(1, 1, 1) -- Reset color to white
    end
end

local sq = 40
local columns = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T"}
local squares = {}
-- Loop through rows 1 to 14
for row = 1, 14 do
  -- Loop through columns A to U
  for colIndex, char in ipairs(columns) do
    local name = char .. row
    -- Calculate coordinates based on indices

    -- colIndex starts at 1, so we subtract 1 for 0-based math
    local xMin = (colIndex - 1) * sq
    local xMax = colIndex * sq
    local yMin = (row - 1) * sq
    local yMax = row * sq
    -- Create the new Square object and insert it into the table
    squares[name] = Square:new(name, xMin, xMax, yMin, yMax, love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 24))
  end
end

return {
    squares = squares,
    sq = sq,
}