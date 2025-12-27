local Colours = require("colours")
local Letter = require("Letter")
local letters = require("letters")
local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()
local currentLetters = {}
local spawnTimer = 0
local initialSpawnInterval = 1.5
local spawnInterval = initialSpawnInterval
local minSpawnInterval = 0.5
local finishLineX = screenWidth/6
local Score = 0
local Lives = 5
local colour = Colours.background
local colourFlashTimer = 0
local initialSpeed = 5
local currentSpeed = initialSpeed
local maxSpeed = 10

function love.load()
  local font = love.graphics.newFont("fonts/PER.TTF", 48)
  love.graphics.setFont(font)
  math.randomseed(os.time())
end

local function SpawnLetters()
  currentLetters[#currentLetters + 1] = Letter:new(
    letters[love.math.random(1, #letters)],
    screenWidth + 100,
    love.math.random(0, screenHeight - 48),
    currentSpeed
  )
end

function love.update(dt)
  spawnTimer = spawnTimer + dt
  if spawnTimer >= spawnInterval then
    SpawnLetters()
    spawnTimer = 0
  end
  for i, letter in ipairs(currentLetters) do
    if letter.x < finishLineX and not letter.success then
      letter.success = true
      Lives = Lives - 1
      colourFlashTimer = 0.07
    end
    if colourFlashTimer > 0 then
      colourFlashTimer = colourFlashTimer - dt
      colour = Colours.lose
      if colourFlashTimer < 0 then
        colour = Colours.background
        colourFlashTimer = 0
      end
    end
    if letter.toBeRemoved then
      table.remove(currentLetters, i)
      Score = Score + 1
      if currentSpeed < maxSpeed then
        currentSpeed = currentSpeed + dt * 0.1
      end
      if spawnInterval > minSpawnInterval then
        spawnInterval = spawnInterval - dt * 0.05
      end
    end
    letter:update(dt)
  end
end

function love.draw()
  love.graphics.setBackgroundColor(colour.r, colour.g, colour.b)
  for _, letter in ipairs(currentLetters) do
    letter:draw()
  end
  love.graphics.line(finishLineX, 0, finishLineX, screenHeight)
  love.graphics.print("Score: "..Score, 10, 10)
  love.graphics.print("Lives: "..Lives, 10, 50)
  colour = Colours.background
end

function love.keypressed(key)
  for _, letter in ipairs(currentLetters) do
    if key:upper() == letter.char and not letter.selected and not letter.success then
      letter.selected = true
    end
  end
end