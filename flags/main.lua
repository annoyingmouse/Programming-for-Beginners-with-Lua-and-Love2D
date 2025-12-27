local FlagsTable = require "flags/flags"
local button = require "Button"
local love = require "love"

local currentFlag = nil

local ScreenWidth, ScreenHeight
local ButtonYPos
local font

local anomalyLetters = {Z = true, Y = true, Q = true, R = true, F = true, H = true, J = true}

local ButtonStates = {"idle", "hover", "clickedWrong", "clickedCorrect"}

local ButtonsTable

local ColoursTable = {
  idle = {r=1, g=1, b=1},
  hover = {r=190/255, g=151/255, b=203/255},
  clickedWrong = {r=1, g=0, b=0},
  clickedCorrect = {r=60/255, g=252/255, b=74/255},
}

local correctAnswerWaitTime = 1.5
local correctAnswerTimer = 0

math.randomseed(os.time())

local function SelectNewFlag()
  for _, v in ipairs(ButtonsTable) do
    v.buttonState = ButtonStates[1]
    v.text = ""
    v.correct = false
  end
  local index = math.random(1, #FlagsTable)
  currentFlag = FlagsTable[index]
  local letter = string.sub(currentFlag.name, 1, 1)
  local anomalyLetterFound = anomalyLetters[letter]

  local locationOfCorrectAnswer = math.random(1,4)
  ButtonsTable[locationOfCorrectAnswer].text = currentFlag.name
  ButtonsTable[locationOfCorrectAnswer].correct = true
  local optionsTable = {}
  for _, v in ipairs(FlagsTable) do
    if anomalyLetterFound then
      if anomalyLetters[string.sub(v.name, 1, 1)] == nil and v.name ~= currentFlag.name then
        table.insert(optionsTable, v.name)
        if #optionsTable >= 3 then
          break
        end
      end
    else
      if string.sub(v.name, 1, 1) == letter and v.name ~= currentFlag.name then
        table.insert(optionsTable, v.name)
        if #optionsTable >= 3 then
          break
        end
      end
    end
    -- if string.sub(v.name, 1, 1) == letter and v.name ~= currentFlag.name then
    --   table.insert(optionsTable, v.name)
    --   if #optionsTable >= 3 then
    --     break
    --   end
    -- end
  end
  for i = 1, 4 do
    if i ~= locationOfCorrectAnswer then
      local optionIndex = math.random(1, #optionsTable)
      ButtonsTable[i].text = optionsTable[optionIndex]
      table.remove(optionsTable, optionIndex)
    end
  end
end

function love.load()
  ScreenWidth, ScreenHeight = love.graphics.getDimensions()
  ButtonYPos = ScreenHeight*(4.5/6)
  font = love.graphics.newFont("fonts/PER.TTF", 36)
  love.graphics.setFont(font)
  ButtonsTable = {
    button:new(0, ScreenWidth/4, ButtonYPos, ButtonYPos+50),
    button:new(ScreenWidth/4, ScreenWidth/2, ButtonYPos, ButtonYPos+50),
    button:new(ScreenWidth/2, ScreenWidth*(3/4), ButtonYPos, ButtonYPos+50),
    button:new(ScreenWidth*(3/4), ScreenWidth, ButtonYPos, ButtonYPos+50),
  }
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
  SelectNewFlag()
end

function love.update(dt)
  if correctAnswerTimer > 0 then
    correctAnswerTimer = correctAnswerTimer - dt
    if correctAnswerTimer <= 0 then
      SelectNewFlag()
    else
      return
    end
  end
  local mouseX, mouseY = love.mouse.getPosition()
  for _, v in ipairs(ButtonsTable) do
    if v.buttonState ~= ButtonStates[3] and v.buttonState ~= ButtonStates[4] then
      if mouseX >= v.xMin and mouseX <= v.xMax and mouseY >= v.yMin and mouseY <= v.yMax then
        v.buttonState = ButtonStates[2]
      else
        v.buttonState = ButtonStates[1]
      end
    end
  end
end

function love.draw()
  love.graphics.setColor(ColoursTable.idle.r, ColoursTable.idle.g, ColoursTable.idle.b)
  love.graphics.setBackgroundColor(0.1, 0.1, 0.1)
  if currentFlag then
    love.graphics.draw(currentFlag.img, 300,100)
  end
  for _, v in ipairs(ButtonsTable) do
    local xPos = v.xMin
    local limit = v.xMax - v.xMin
    local yPos = v.yMin
    local colour = ColoursTable.idle
    if v.buttonState == "hover" then
      colour = ColoursTable.hover
    elseif v.buttonState == "clickedWrong" then
      colour = ColoursTable.clickedWrong
    elseif v.buttonState == "clickedCorrect" then
      colour = ColoursTable.clickedCorrect
    end
    love.graphics.setColor(colour.r, colour.g, colour.b)
    love.graphics.printf(v.text, xPos, yPos, limit, "center")
  end
end

function love.mousepressed()
  local mouseX, mouseY = love.mouse.getPosition()
  for _, v in ipairs(ButtonsTable) do
    if mouseX >= v.xMin and mouseX <= v.xMax and mouseY >= v.yMin and mouseY <= v.yMax then
      if v.correct then
        v.buttonState = ButtonStates[4]
        correctAnswerTimer = correctAnswerWaitTime
      else
        v.buttonState = ButtonStates[3]
      end
    end
  end
end
