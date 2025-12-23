
local Word = {}
Word.__index = Word
function Word:__call(Letters)
  local obj = {}
  obj.letters = Letters
  setmetatable(obj, Word)
  return obj
end

Word.populatePositions = function(self)
  for index, letter in ipairs(self.letters) do
    letter.x = (index - 1) * 50
    letter.y = 0
  end
end

return Word