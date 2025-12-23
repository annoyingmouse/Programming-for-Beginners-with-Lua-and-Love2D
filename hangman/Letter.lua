--[[
888              888    888
888              888    888
888              888    888
888      .d88b.  888888 888888 .d88b.  888d888
888     d8P  Y8b 888    888   d8P  Y8b 888P"
888     88888888 888    888   88888888 888
888     Y8b.     Y88b.  Y88b. Y8b.     888
88888888 "Y8888   "Y888  "Y888 "Y8888  888
]]
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