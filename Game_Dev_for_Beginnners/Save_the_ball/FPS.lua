local function FPS ()
  love.graphics.setColor(1, 1, 1) -- White
  love.graphics.printf(
    "FPS: " .. tostring(love.timer.getFPS()),
    love.graphics.newFont(16),
    10,
    love.graphics.getHeight() - 30,
    love.graphics.getWidth()
  )
end

return FPS