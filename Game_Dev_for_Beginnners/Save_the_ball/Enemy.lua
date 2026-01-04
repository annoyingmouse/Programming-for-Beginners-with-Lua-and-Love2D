local atan2 = require("atan2")

local Enemy = {}
function Enemy:new()
  local dice = math.random(1, 4)
  local _x, _y
  local _radius = 20
  local width = love.graphics.getWidth()
  local height = love.graphics.getHeight()

  if dice == 1 then
    _x = math.random(0, width)
    _y = -_radius * 4
  elseif dice == 2 then
    _x = math.random(0, width)
    _y = height + _radius * 4
  elseif dice == 3 then
    _x = -_radius * 4
    _y = math.random(0, height)
  else
    _x = width + _radius * 4
    _y = math.random(0, height)
  end

  local obj = {
    x = _x,
    y = _y,
    level = 1,
    radius = _radius
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Enemy.update = function(self, player_x, player_y, dt)
  local speedMultiplier = 1 + (self.level - 1) * 0.1
  local angle = atan2(player_y - self.y, player_x - self.x)
  self.x = self.x + math.cos(angle) * (80 + (self.level - 1) * 15) * speedMultiplier * dt
  self.y = self.y + math.sin(angle) * (80 + (self.level - 1) * 15) * speedMultiplier * dt
  -- if player_x > self.x then
  --   self.x = self.x + (80 + (self.level - 1) * 15) * speedMultiplier
  -- else
  --   self.x = self.x - (80 + (self.level - 1) * 15) * speedMultiplier
  -- end
  -- if player_x - self.x > 0 then
  --   self.x = self.x + self.level
  -- else
  --   self.x = self.x - self.level
  -- end
  -- if player_y - self.y > 0 then
  --   self.y = self.y + self.level
  -- else
  --   self.y = self.y - self.level
  -- end
end

Enemy.draw = function(self)
  love.graphics.setColor(1, 0.5, 0.7) -- Pink
  love.graphics.circle("fill", self.x, self.y, self.radius)
  love.graphics.setColor(1, 1, 1) -- White
end

return Enemy