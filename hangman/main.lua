require("words")
require("colours")
require("messages")

math.randomseed(os.time())

ChocolateCoveredRaindropsBOLD = love.graphics.newFont("Chocolate Covered Raindrops BOLD.ttf", 80)
WrongLetterPressed = false
RedFlashDuration = 0.05
RedFlashTimer = 0
FalseLetters = {}
Lives = 10

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
    lose()
  elseif CurrentWord.completed then
    win()
  end
  CurrentWord:draw()
end

function SelectNewWord()
  CurrentWord = WordsToGuess[love.math.random(1, #WordsToGuess)]
  print(CurrentWord.word)
  CurrentWord:reset()
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