local Square = {}
function Square:new(name, x1, x2, y1, y2)
  local obj = {
    name = name,
    x1 = x1,
    x2 = x2,
    y1 = y1,
    y2 = y2,
    visible = false,
    content = "",
    font = nil,
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

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
    love.graphics.rectangle("line", self.x1, self.y1, self.x2 - self.x1, self.y2 - self.y1)
    if self.visible then
        love.graphics.setFont(self.font)
        love.graphics.setColor(self:getColour())
        love.graphics.printf(
            self.content,
            self.x1,
            self.y1 + (self.y2 - self.y1) / 2 - (self.font:getHeight() / 2), -- Vertical centering
            self.x2 - self.x1,
            "center" -- Horizontal centering
        )
        love.graphics.setColor(1, 1, 1) -- Reset color to white
    end
end

local sq = 40
local columns = {"A","B","C","D","E","F","G","H","I","J","K","L","M","N", "O", "P","Q","R","S","T"}
local squares = {}
-- Loop through rows 1 to 14
for row = 1, 14 do
  -- Loop through columns A to U
  for colIndex, char in ipairs(columns) do
    local name = char .. row
    -- Calculate coordinates based on indices

    -- colIndex starts at 1, so we subtract 1 for 0-based math
    local x1 = (colIndex - 1) * sq
    local x2 = colIndex * sq
    local y1 = (row - 1) * sq
    local y2 = row * sq
    -- Create the new Square object and insert it into the table
    squares[name] = Square:new(name, x1, x2, y1, y2)
  end
end

return {
    squares = squares,
    sq = sq,
}