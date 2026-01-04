local Player = {}
function Player:new()
  local obj = {
    x = 400,
    y = 300,
    radius = 20,
    speed = 200
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Player.update = function(self, running)
  self.x, self.y = love.mouse.getPosition()
  local playerRadius = not running and self.radius / 2 or self.radius
  self.x = math.max(playerRadius, math.min(love.graphics.getWidth() - playerRadius, self.x))
  self.y = math.max(playerRadius, math.min(love.graphics.getHeight() - playerRadius, self.y))
end

Player.draw = function(self, running)
  local playerRadius = not running and self.radius / 2 or self.radius
  love.graphics.setColor(0.2, 0.6, 1) -- Blue
  love.graphics.circle("fill", self.x, self.y, playerRadius)
  love.graphics.setColor(1, 1, 1) -- White
end

return Player