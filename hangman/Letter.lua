local Letter = {}
Letter.__index = Letter
function Letter:__call(char)
  local obj = {}
  obj.char = char
  obj.x = 0
  obj.y = 0
  obj.startX = 0
  obj.startY = 0
  obj.width = 0
  setmetatable(obj, Letter)
  return obj
end

return Letter