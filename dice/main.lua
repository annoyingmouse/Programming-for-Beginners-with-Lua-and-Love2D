math.randomseed(os.time())
local Dice1 = nil
local Dice2 = nil
local PauseDuration = 0.7
local Pause = 0
local Cheater = false
local love = require "love"

function love.load()
  local font = love.graphics.newFont("fonts/PER.TTF", 50)
  love.graphics.setFont(font)
end

function love.update(dt)
  Pause = Pause - dt
  if Pause <= 0 then
    Pause = 0
  end
end

function love.draw()
  if Pause > 0 then
    return
  end
  if Dice1 then
    love.graphics.printf("Dice 1: " .. Dice1, 200, 200, 800, "left")
  end
  if Dice2 then
    love.graphics.printf("Dice 2: " .. Dice2, 200, 300, 800, "left")
  end
  if Dice1 and Dice2 then
    love.graphics.printf("Total: " .. (Dice1 + Dice2), 200, 400, 800, "left")
  end
end

function love.mousepressed(_, _, button)
  if button == 1 then
    Pause = PauseDuration
    if Cheater then
      Dice1 = 6
      Dice2 = 6
      return
    end
    Dice1 = math.random(1, 6)
    Dice2 = math.random(1, 6)
  end
end

function love.keypressed(key)
  if(key == "f2") then
    Cheater = not Cheater
  end
end