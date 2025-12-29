local Button = {}
function Button:new(label, difficulty, xMin, xMax, yMin, yMax, state)
  local obj = {
    label = label,
    difficulty = difficulty,
    xMin = xMin,
    xMax = xMax,
    yMin = yMin,
    yMax = yMax,
    state = state,
    font = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 18),
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Button.draw = function(self)
  love.graphics.setFont(self.font)
  if self.state == 2 then
    love.graphics.setColor(0.5,0,0.5)
  else
    love.graphics.setColor(1, 1, 1)
  end
  love.graphics.rectangle("line", self.xMin + 25, self.yMin , self.xMax - self.xMin - 50, self.yMax - self.yMin)
  love.graphics.printf(
    self.label,
    self.xMin,
    self.yMin + (self.yMax - self.yMin) / 2 - (self.font:getHeight() / 2),
    self.xMax - self.xMin,
    "center"
  )
  love.graphics.setColor(1, 1, 1)
end

Button.getRectForChecking = function(self)
  return {
    xMin = self.xMin + 25,
    xMax = self.xMax - 25,
    yMin = self.yMin,
    yMax = self.yMax,
  }
end

local height = love.graphics.getHeight()
local width = love.graphics.getWidth()

local difficulties = {
  EASY = 10,
  MEDIUM = 25,
  HARD = 40,
}

local buttonStates = {
  NORMAL = 1,
  HOVERED = 2,
  PRESSED = 3,
}

local yMin = height / 2 + 100
local yMax = height / 2 + 140

local buttons = {
  Button:new("Easy", difficulties.EASY, 0, width/3, yMin, yMax, buttonStates.NORMAL),
  Button:new("Medium", difficulties.MEDIUM, width/3, 2*width/3, yMin, yMax, buttonStates.NORMAL),
  Button:new("Hard", difficulties.HARD, 2*width/3, width, yMin, yMax, buttonStates.NORMAL),
}

return buttons