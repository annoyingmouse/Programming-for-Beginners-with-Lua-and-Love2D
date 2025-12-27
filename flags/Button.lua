local Button = {}
function Button:new(xMin, xMax, yMin, yMax)
  local obj = {
    xMin = xMin,
    xMax = xMax,
    yMin = yMin,
    yMax = yMax,
    state = "idle",
    text = "",
    correct = false
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

return Button