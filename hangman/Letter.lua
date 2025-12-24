local Letter = {}
Letter.__index = Letter
function Letter:new(char, startX, startY, width)
  local obj = {}
  obj.char = char
  obj.startX = startX
  obj.startY = startY
  obj.width = width
  obj.guessed = false
  setmetatable(obj, Letter)
  return obj
end

return Letter