
--[[
8888888                                         888
  888                                           888
  888                                           888
  888   88888b.d88b.  88888b.   .d88b.  888d888 888888
  888   888 "888 "88b 888 "88b d88""88b 888P"   888
  888   888  888  888 888  888 888  888 888     888
  888   888  888  888 888 d88P Y88..88P 888     Y88b.
8888888 888  888  888 88888P"   "Y88P"  888      "Y888
                      888
                      888
                      888
                      888
]]
local letter = require("Letter")

--[[
888       888                      888       .d8888b.  888
888   o   888                      888      d88P  Y88b 888
888  d8b  888                      888      888    888 888
888 d888b 888  .d88b.  888d888 .d88888      888        888  8888b.  .d8888b  .d8888b
888d88888b888 d88""88b 888P"  d88" 888      888        888     "88b 88K      88K
88888P Y88888 888  888 888    888  888      888    888 888 .d888888 "Y8888b. "Y8888b.
8888P   Y8888 Y88..88P 888    Y88b 888      Y88b  d88P 888 888  888      X88      X88
888P     Y888  "Y88P"  888     "Y88888       "Y8888P"  888 "Y888888  88888P'  88888P'
]]
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


--[[
888b     d888          888    888                    888
8888b   d8888          888    888                    888
88888b.d88888          888    888                    888
888Y88888P888  .d88b.  888888 88888b.   .d88b.   .d88888 .d8888b
888 Y888P 888 d8P  Y8b 888    888 "88b d88""88b d88" 888 88K
888  Y8P  888 88888888 888    888  888 888  888 888  888 "Y8888b.
888   "   888 Y8b.     Y88b.  888  888 Y88..88P Y88b 888      X88
888       888  "Y8888   "Y888 888  888  "Y88P"   "Y88888  88888P'
]]
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

return Word