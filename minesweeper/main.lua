local love = require("love")
local checkNeighbors = require('CheckNeighbors')
local getAdjacentSquares = require('GetAdjacentSquares')
local buttons = require('MenuButtons')
local squares = require('squares').squares
local SmallFont = nil
local MediumFont = nil
local LargeFont = nil
local percentageMines = 25
local numberOfBombs = 0
local GameStates = {
  PLAYING = 1,
  MENU = 2
}
local GameState = nil

local function NewBoard(Font)

  for square in pairs(squares) do
    squares[square].font = Font
    if math.random(100) <= percentageMines then
        squares[square].content = "#"
        numberOfBombs = numberOfBombs + 1
    end
  end
  for square in pairs(squares) do
    if squares[square].content ~= "#" then
      local adjacentMines = checkNeighbors(square, squares)
      squares[square].content = tostring(adjacentMines)
    end
  end
end

function love.load()
  GameState = GameStates.MENU
  SmallFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 18)
  MediumFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 24)
  LargeFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 36)
  love.graphics.setFont(MediumFont)
  math.randomseed(os.time())
end

function love.update()

end

local function processSquare(square)
  square.visible = true
  if square.content == "0" then
    local adjacentSquares = getAdjacentSquares(square.name)
    for _, adjacentSquareName in ipairs(adjacentSquares) do
      local adjacentSquare = squares[adjacentSquareName]
      if adjacentSquare and not adjacentSquare.visible then
        processSquare(adjacentSquare)
      end
    end
  end
  if square.content == "#" then
    print("Game Over!")
    for _, bustedSquare in pairs(squares) do
      if not bustedSquare.visible then
        bustedSquare.visible = true
      end
    end
  end
end

local function HandleMenuClick(x, y)
  for _, button in ipairs(buttons) do
    if x >= button.xMin and x <= button.xMax and y >= button.yMin and y <= button.yMax then
      percentageMines = button.difficulty
      numberOfBombs = 0
      NewBoard(MediumFont)
      GameState = GameStates.PLAYING
    end
  end
end

local function HandleGameClick(x, y, button)
  if button == 1 then
    for _, square in pairs(squares) do
      if x >= square.x1 and x <= square.x2 and y >= square.y1 and y <= square.y2 then
        processSquare(square)
      end
    end
  end
  if button == 2 then
    for _, square in pairs(squares) do
      if x >= square.x1 and x <= square.x2 and y >= square.y1 and y <= square.y2 then
        if square.content == "#" then
          print("Mine found")
          square.visible = true
        else
          print("No mine here")
        end
      end
    end
  end
end

function love.mousepressed(x, y, button)
  if GameState == GameStates.PLAYING then
    HandleGameClick(x, y, button)
  elseif GameState == GameStates.MENU then
    HandleMenuClick(x, y)
  end
end

local function DrawPlayingScreen()
  for _, square in pairs(squares) do
    square:draw()
  end
  love.graphics.printf(
    "Mines: " .. numberOfBombs,
    0,
    love.graphics.getHeight() - 35,
    love.graphics.getWidth(),
    "center"
  )
end

local function DrawMenuScreen()
  love.graphics.setFont(LargeFont)
  love.graphics.printf(
    "Minesweeper",
    0,
    (love.graphics.getHeight() / 2 - (LargeFont and LargeFont:getHeight() or 0) / 2) - 100,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.setFont(MediumFont)
  love.graphics.printf(
    "Select a difficulty",
    0,
    love.graphics.getHeight() / 2,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.setFont(SmallFont)
  for _, button in ipairs(buttons) do
    button:draw()
  end
end

function love.draw()
  if GameState == GameStates.PLAYING then
    DrawPlayingScreen()
  elseif GameState == GameStates.MENU then
    DrawMenuScreen()
  end
end