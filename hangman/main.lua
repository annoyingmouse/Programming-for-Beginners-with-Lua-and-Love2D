local word = require("Word")
local dump = require("utils/dump")
local margin = 50
ChocolateCoveredRaindropsBOLD = love.graphics.newFont("Chocolate Covered Raindrops BOLD.ttf", 80)

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
end


function love.update()

end

function love.draw()
  love.graphics.setFont(ChocolateCoveredRaindropsBOLD)
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

function ProcessWrongGuess()
  Lives = Lives - 1
  print("Lives remaining: " .. Lives)
end

function ProcessCorrectGuess(letter)
  print(letter.. " is in the word!")
end

function love.keypressed(key)
  local found = false
  for _, letterObj in ipairs(CurrentWord.letters) do
    if key == letterObj.char then
      CurrentWord:setGuessed(key)
      ProcessCorrectGuess(key)
      found = true
      if CurrentWord.completed then
        print("Congratulations! You've guessed the word: " .. CurrentWord.word)
      end
    end
  end
  if not found then
    ProcessWrongGuess()
  end

end

function InitiateNewGame()
  Lives = 10
  SelectNewWord()
end

function love.mousepressed(x, y, button)
  if CurrentWord.completed or Lives <= 0 then
    print("Starting new game...")
    InitiateNewGame()
  end
  
end