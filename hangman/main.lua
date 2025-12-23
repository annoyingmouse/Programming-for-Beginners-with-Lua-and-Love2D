local letter = require("Letter")
local word = require("Word")


local apple = word({
  letter("a"),
  letter("p"),
  letter("p"),
  letter("l"),
  letter("e"),
})

-- apple:populatePositions()

-- for index, value in ipairs(apple.letters) do
--   print(string.format("Letter: %s", value.char))
-- end



WordsToGuess = {
  {"a", "p", "p", "l", "e"},
  {"h", "o", "r", "i", "z", "o", "n"},
  {"c", "o", "m", "p", "u", "t", "e", "r"},
  {"m", "u", "s", "i", "c"},
  {"l", "o", "v", "e"},
  {"s", "p", "a", "c", "e"},
  {"t", "e", "c", "h", "n", "o", "l", "o", "g", "y"},
  {"i", "n", "t", "e", "r", "n", "e", "t"},
  {"d", "e", "v", "e", "l", "o", "p", "m", "e", "n", "t"},
  {"a", "r", "t", "i", "f", "i", "c", "i", "a", "l"},
}

function love.load()
  InitiateNewGame()
end


function love.update()
  
end

function love.draw()
  local margin = 50
  local windowWidth, windowHeight = love.graphics.getDimensions()
  local wordWidth = CurrentWordLength + (CurrentWordLength - 1) / 2
  local lineWidth = (windowWidth - 2 * margin) / wordWidth
  for i = 0, CurrentWordLength - 1 do
    love.graphics.line(
      (i * (lineWidth + (lineWidth / 2))) + margin,
      windowHeight * 0.75,
      (i * (lineWidth + (lineWidth / 2))) + lineWidth + margin,
      windowHeight * 0.75)
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
  for i, letter in ipairs(CurrentWord) do
    if key == letter then
      ProcessCorrectGuess(letter)
      if CurrentWordProgress == CurrentWordLength then
        print("Congratulations! You've guessed the word: " .. table.concat(CurrentWord))
      end
    else 
      ProcessWrongGuess()
    end
  end
end

function InitiateNewGame()
  Lives = 10
  SelectNewWord()
  CurrentWordProgress = 0
  print("Current word to guess: " .. table.concat(CurrentWord))
end

function love.mousepressed(x, y, button)
  InitiateNewGame()
end