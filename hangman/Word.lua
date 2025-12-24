
local letter = require("Letter")

local Word = {}
function Word:new(margin, string, width, height)
  local obj = {
    word = string,
    length = #string,
    letters = {},
    completed = false,
  }
  local wordWidth = obj.length + (obj.length - 1) / 2
  local lineWidth = (width - 2 * margin) / wordWidth
  for i = 1, #string do
    table.insert(
      obj.letters,
      letter:new(
        string:sub(i, i),
        ((i - 1) * (lineWidth + (lineWidth / 2))) + margin,
        height * 0.75,
        lineWidth
      )
    )
  end
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Word.reset = function(self)
  self.completed = false
  for _, letterObj in ipairs(self.letters) do
    letterObj.guessed = false
  end
end

Word.setGuessed = function(self, char)
  if self.completed then return end
  local allGuessed  = true
  for _, letterObj in ipairs(self.letters) do
    if letterObj.char == char then
      letterObj.guessed = true
    end
    allGuessed = allGuessed and letterObj.guessed
  end
  self.completed = allGuessed
end

Word.draw = function(self)
  for _, letterObj in ipairs(self.letters) do
    letterObj:draw()
  end
end
return Word