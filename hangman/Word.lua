local Word = {}
Word.__index = Word
function Word:new(margin, Letters, width, height)
  local obj = {}
  obj.letters = Letters
  obj.length = #Letters
  obj.word = ""
  for _, letter in ipairs(Letters) do
    obj.word = obj.word .. letter.char
  end
  local wordWidth = obj.length + (obj.length - 1) / 2
  local lineWidth = (width - 2 * margin) / wordWidth
  for i = 0, obj.length - 1 do
    obj.letters[i + 1].startX = (i * (lineWidth + (lineWidth / 2))) + margin
    obj.letters[i + 1].startY = height * 0.75
    obj.letters[i + 1].width = lineWidth
  end
  setmetatable(obj, Word)
  return obj
end



return Word