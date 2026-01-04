local Button = {}
function Button:new(text, x, y, width, height, onClick)
  local obj = {
    text = text or "Button",
    x = x or 0,
    y = y or 0,
    width = width or 100,
    height = height or 100,
    onClick = onClick or function() print("This button has no function attached") end,
    hovered = false
  }
  setmetatable(obj, self)
  self.__index = self
  return obj
end

Button.update = function(self, mouse_x, mouse_y, mouse_pressed)
  self.hovered = mouse_x >= self.x and mouse_x <= self.x + self.width and
                 mouse_y >= self.y and mouse_y <= self.y + self.height
  if self.hovered and mouse_pressed then
    self.onClick()
  end
end

Button.draw = function(self)
  love.graphics.setColor(0.7, 0.7, 0.7) -- Grey
  if self.hovered then
    love.graphics.setColor(0.9, 0.9, 0.9) -- Lighter Grey
  end
  love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
  love.graphics.setColor(0, 0, 0) -- Black
  love.graphics.printf(
    self.text,
    self.x,
    self.y + self.height / 2 - love.graphics.getFont():getHeight() / 2,
    self.width,
    "center"
  )
  love.graphics.setColor(1, 1, 1) -- White
end

return Button