local Letter = {}
function Letter:new(char, startX, startY, width)
  local obj = {
    char = char,
    startX = startX,
    startY = startY,
    width = width,
    guessed = false
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Letter.draw = function(self)
  if self.guessed then
    love.graphics.printf(
      self.char,
      self.startX - love.graphics.getFont():getWidth(self.char) / 2,
      self.startY - love.graphics.getFont():getHeight(),
      self.width,
      "center"
    )
  else
    love.graphics.line(
      self.startX,
      self.startY,
      self.startX + self.width,
      self.startY
    )
  end
end
return Letter