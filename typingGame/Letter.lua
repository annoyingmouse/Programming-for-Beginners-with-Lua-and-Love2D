local Colours = require("colours")
local Letter = {}
function Letter:new(char, x, y, initialSpeed)
  local obj = {
    char = char,
    x = x,
    y = y,
    initialSpeed = initialSpeed or 5,
    selected = false,
    toBeRemoved = false,
    success = false,
    countdownToRemoval = 1
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Letter.update = function(self, dt)
  if not self.selected and not self.success then
    self.x = self.x - self.initialSpeed
  else
    if self.success then
      self.x = self.x - self.initialSpeed / 5
    end
    self.countdownToRemoval = self.countdownToRemoval - dt
    if self.countdownToRemoval <= 0 then
      self.toBeRemoved = true
    end
  end
end

Letter.draw = function(self)
  if self.selected then
    love.graphics.setColor(Colours.win.r, Colours.win.g, Colours.win.b)
  elseif self.success then
    love.graphics.setColor(Colours.lose.r, Colours.lose.g, Colours.lose.b)
  end
  love.graphics.printf(self.char, self.x, self.y, 100, "left")
  love.graphics.setColor(Colours.neutral.r, Colours.neutral.g, Colours.neutral.b)
end

return Letter