local WordsToGuess = require("words")
local Colours = require("colours")
local messages = require("messages")
local love = require("love")

math.randomseed(os.time())

local ChocolateCoveredRaindropsBOLD = love.graphics.newFont("Chocolate Covered Raindrops BOLD.ttf", 80)
local WrongLetterPressed = false
local RedFlashDuration = 0.05
local RedFlashTimer = 0
local FalseLetters = {}
local Lives = 10
local CurrentWord = nil

local function SelectNewWord()
  CurrentWord = WordsToGuess[love.math.random(1, #WordsToGuess)]
  print(CurrentWord.word)
  CurrentWord:reset()
end

local function InitiateNewGame()
  Lives = 10
  SelectNewWord()
  FalseLetters = {}
end

function love.load()
  InitiateNewGame()
  love.graphics.setFont(ChocolateCoveredRaindropsBOLD)
end

function love.update(dt)
  if WrongLetterPressed then
    RedFlashTimer = RedFlashTimer - dt
    if RedFlashTimer <= 0 then
      WrongLetterPressed = false
      RedFlashTimer = 0
    end
  end
end

function love.draw()
  local colour
  if Lives <= 0 then
    colour = Colours.lose
  elseif CurrentWord and CurrentWord.completed then
    colour = Colours.win
  elseif WrongLetterPressed then
    colour = Colours.wrong
  else
    colour = Colours.neutral
  end
  love.graphics.setBackgroundColor(colour.r, colour.g, colour.b)
  love.graphics.print("Lives: " .. Lives, 570, 20)
  if Lives == 0 then
    messages.lose()
  elseif CurrentWord and CurrentWord.completed then
    messages.win()
  end
  if CurrentWord then
    CurrentWord:draw()
  end
end



local function WrongLetterAlreadyGuessed(letter)
  for _, l in ipairs(FalseLetters) do
    if l == letter then
      return true
    end
  end
  return false
end

local function ProcessWrongGuess(key)
  if WrongLetterAlreadyGuessed(key) == false then
    table.insert(FalseLetters, key)
    Lives = Lives > 0 and Lives - 1 or 0
  end
  WrongLetterPressed = true
  RedFlashTimer = RedFlashDuration
end

function love.keypressed(key)
  if Lives <= 0 or not CurrentWord or CurrentWord.completed then
    return
  end
  local found = false
  for _, letterObj in ipairs(CurrentWord.letters or {}) do
    if key == letterObj.char then
      CurrentWord:setGuessed(key)
      found = true
      if CurrentWord.completed then
        print("Congratulations! You've guessed the word: " .. CurrentWord.word)
      end
    end
  end
  if not found then
    ProcessWrongGuess(key)
  end
end

function love.mousepressed()
  if Lives <= 0 or (CurrentWord and CurrentWord.completed) then
    print("Starting new game...")
    InitiateNewGame()
  end
end