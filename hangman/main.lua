local word = require("Word")
local dump = require("utils/dump")
local margin = 50
ChocolateCoveredRaindropsBOLD = love.graphics.newFont("Chocolate Covered Raindrops BOLD.ttf", 80)
Colours = {
  win = {r = 26/255, g = 74/255, b = 19/255},
  lose = {r = 1, g = 0, b = 0},
  wrong = {r = 0.3, g = 0, b = 0},
  neutral = {r = 0, g = 0, b = 0},
}
WrongLetterPressed = false
RedFlashDuration = 0.05
RedFlashTimer = 0
FalseLetters = {}
Lives = 10

WordsToGuess = {
  word:new(margin, "apple", love.graphics.getDimensions()),
  word:new(margin, "horizon", love.graphics.getDimensions()),
  word:new(margin, "computer", love.graphics.getDimensions()),
  word:new(margin, "music", love.graphics.getDimensions()),
  word:new(margin, "love", love.graphics.getDimensions()),
  word:new(margin, "space", love.graphics.getDimensions()),
  word:new(margin, "technology", love.graphics.getDimensions()),
  word:new(margin, "internet", love.graphics.getDimensions()),
  word:new(margin, "development", love.graphics.getDimensions()),
  word:new(margin, "artificial", love.graphics.getDimensions()),
}

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
  elseif CurrentWord.completed then
    colour = Colours.win
  elseif WrongLetterPressed then
    colour = Colours.wrong
    
  else
    colour = Colours.neutral
  end
  love.graphics.setBackgroundColor(colour.r, colour.g, colour.b)
  love.graphics.print("Lives: " .. Lives, 570, 20)
  if Lives == 0 then
    love.graphics.printf(
      "Game Over! Click to restart.",
      0,
      love.graphics.getHeight() / 2 - love.graphics.getFont():getHeight() / 2,
      love.graphics.getWidth(),
      "center"
    )
  end
  if CurrentWord.completed then
    love.graphics.printf(
      "Congratulations! Click to play again.",
      0,
      love.graphics.getHeight() / 2 - love.graphics.getFont():getHeight() / 2,
      love.graphics.getWidth(),
      "center"
    )
  end

  for _, letterObj in ipairs(CurrentWord.letters) do
    if letterObj.guessed then
      love.graphics.printf(
        letterObj.char,
        letterObj.startX - love.graphics.getFont():getWidth(letterObj.char) / 2,
        letterObj.startY - love.graphics.getFont():getHeight(),
        letterObj.width,
        "center"
      )
      -- love.graphics.line(
      --   letterObj.startX,
      --   letterObj.startY,
      --   letterObj.startX + letterObj.width,
      --   letterObj.startY
      -- )
    else
      love.graphics.line(
        letterObj.startX,
        letterObj.startY,
        letterObj.startX + letterObj.width,
        letterObj.startY
      )
    end
  end
end

function SelectNewWord()
  CurrentWord = WordsToGuess[love.math.random(1, #WordsToGuess)]
  CurrentWord:reset()
end


function ProcessGuess(letter)

end

function WrongLetterAlreadyGuessed(letter)
  for _, l in ipairs(FalseLetters) do
    if l == letter then
      return true
    end
  end
  return false
end

function ProcessWrongGuess(key)
  if WrongLetterAlreadyGuessed(key) == false then
    table.insert(FalseLetters, key)
    Lives = Lives > 0 and Lives - 1 or 0
  end
  WrongLetterPressed = true
  RedFlashTimer = RedFlashDuration
end

function love.keypressed(key)
  if Lives <= 0 or CurrentWord.completed then
    return
  end
  local found = false
  for _, letterObj in ipairs(CurrentWord.letters) do
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

function InitiateNewGame()
  Lives = 10
  SelectNewWord()
  FalseLetters = {}
end

function love.mousepressed(x, y, button)
  if CurrentWord.completed or Lives <= 0 then
    print("Starting new game...")
    InitiateNewGame()
  end
  
end