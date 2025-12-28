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
local colour = Colours.background
local colourFlashTimer = 0
local initialSpeed = 5
local currentSpeed = initialSpeed
local maxSpeed = 10
local largeFont = nil
local smallFont = nil

function love.load()
  smallFont = love.graphics.newFont("fonts/PER.TTF", 36)
  largeFont = love.graphics.newFont("fonts/PER.TTF", 48)
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
      Score = Score - 1
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
      if currentSpeed < maxSpeed then
        currentSpeed = currentSpeed + 0.25
      end
      if spawnInterval > minSpawnInterval then
        spawnInterval = spawnInterval - 0.025
      end
    end
    letter:update(dt)
  end
end

function love.draw()
  love.graphics.setBackgroundColor(colour.r, colour.g, colour.b)
  love.graphics.setFont(largeFont)
  for _, letter in ipairs(currentLetters) do
    letter:draw()
  end
  love.graphics.line(finishLineX, 0, finishLineX, screenHeight)
  love.graphics.setFont(smallFont)
  love.graphics.printf("Score: "..Score, 0, screenHeight - 40, screenWidth, "center")
  colour = Colours.background
end

function love.keypressed(key)
  local correctLetterPressed = false
  for _, letter in ipairs(currentLetters) do
    if key:upper() == letter.char and not letter.selected and not letter.success then
      letter.selected = true
      correctLetterPressed = true
    end
  end
  if correctLetterPressed then
    Score = Score + 1
  else
    colour = Colours.warning
    colourFlashTimer = 0.07
    Score = Score - 1
  end
end