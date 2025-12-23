local Letter = {}
Letter.__index = Letter
function Letter:new(char)
  local obj = {}
  obj.char = char
  obj.startX = 0
  obj.startY = 0
  obj.width = 0
  obj.guessed = false
  setmetatable(obj, Letter)
  return obj
end

return Letter