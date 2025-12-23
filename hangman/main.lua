local letter = require("Letter")
local word = require("Word")
local dump = require("utils/dump")
ChocolateCoveredRaindropsBOLD = love.graphics.newFont("Chocolate Covered Raindrops BOLD.ttf", 64)

WordsToGuess = {
  word:new(50, {letter:new("a"), letter:new("p"), letter:new("p"), letter:new("l"), letter:new("e")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("h"), letter:new("o"), letter:new("r"), letter:new("i"), letter:new("z"), letter:new("o"), letter:new("n")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("c"), letter:new("o"), letter:new("m"), letter:new("p"), letter:new("u"), letter:new("t"), letter:new("e"), letter:new("r")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("m"), letter:new("u"), letter:new("s"), letter:new("i"), letter:new("c")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("l"), letter:new("o"), letter:new("v"), letter:new("e")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("s"), letter:new("p"), letter:new("a"), letter:new("c"), letter:new("e")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("t"), letter:new("e"), letter:new("c"), letter:new("h"), letter:new("n"), letter:new("o"), letter:new("l"), letter:new("o"), letter:new("g"), letter:new("y")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("i"), letter:new("n"), letter:new("t"), letter:new("e"), letter:new("r"), letter:new("n"), letter:new("e"), letter:new("t")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("d"), letter:new("e"), letter:new("v"), letter:new("e"), letter:new("l"), letter:new("o"), letter:new("p"), letter:new("m"), letter:new("e"), letter:new("n"), letter:new("t")}, love.graphics.getDimensions()),
  word:new(50, {letter:new("a"), letter:new("r"), letter:new("t"), letter:new("i"), letter:new("f"), letter:new("i"), letter:new("c"), letter:new("i"), letter:new("a"), letter:new("l")}, love.graphics.getDimensions()),
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
  CurrentWordLength = #CurrentWord
end

function ProcessGuess(letter)
  
end

function ProcessWrongGuess()
  Lives = Lives - 1
  print("Lives remaining: " .. Lives)
end

function ProcessCorrectGuess(letter)
  CurrentWordProgress = CurrentWordProgress + 1
  print(letter.. " is in the word!")
end

function love.keypressed(key)
  local found = false
  for _, letterObj in ipairs(CurrentWord.letters) do
    if key == letterObj.char and not letterObj.guessed then
      letterObj.guessed = true
      ProcessCorrectGuess(letterObj.char)
      found = true
      if CurrentWordProgress == CurrentWordLength then
        print("Congratulations! You've guessed the word: " .. CurrentWord.word)
      end
    end
  end
  if not found then
    ProcessWrongGuess()
  end
  -- for i, letter in ipairs(CurrentWord) do
  --   if key == letter then
  --     ProcessCorrectGuess(letter)
  --     if CurrentWordProgress == CurrentWordLength then
  --       print("Congratulations! You've guessed the word: " .. table.concat(CurrentWord))
  --     end
  --   else 
  --     ProcessWrongGuess()
  --   end
  -- end
end

function InitiateNewGame()
  Lives = 10
  SelectNewWord()
  CurrentWordProgress = 0
  print(dump(CurrentWord))
end

function love.mousepressed(x, y, button)
  InitiateNewGame()
end