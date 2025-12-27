local messages = {}

function messages.lose()
  love.graphics.printf(
    "Game Over! Click to restart.",
    0,
    love.graphics.getHeight() / 2 - love.graphics.getFont():getHeight() / 2,
    love.graphics.getWidth(),
    "center"
  )
end

function messages.win()
  love.graphics.printf(
    "Congratulations! Click to play again.",
    0,
    love.graphics.getHeight() / 2 - love.graphics.getFont():getHeight() / 2,
    love.graphics.getWidth(),
    "center"
  )
end

return messages