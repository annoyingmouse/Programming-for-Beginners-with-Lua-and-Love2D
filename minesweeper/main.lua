local love = require("love")
local checkNeighbors = require('CheckNeighbors')
local getAdjacentSquares = require('GetAdjacentSquares')
local buttons = require('MenuButtons')
local squares = require('squares')
local withinBoundingBox = require('WithinBoundingBox')
local DrawFunctions = require('DrawFunctions')
local percentageMines = nil
local numberOfBombs = 0
local numberOfSquaresFlagged = 0
local GameStates = {
  PLAYING = 1,
  MENU = 2,
  LOST = 3,
  WON = 4
}
local GameState = nil
local mouseX, mouseY = 0, 0

local function NewBoard()
  numberOfBombs = 0
  for square in pairs(squares) do
    squares[square].visible = false
    squares[square].content = ""
    squares[square].flagged = false
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
  math.randomseed(os.time())
end

local function MenuUpdate()
  for _, button in ipairs(buttons) do
    if withinBoundingBox(mouseX, mouseY, button:getRectForChecking()) then
      button.state = 2
    else
      button.state = 1
    end
  end
end


function love.update()
  mouseX, mouseY = love.mouse.getPosition()
  if GameState == GameStates.MENU then
    MenuUpdate()
  end
end

local function processSquare(square)
  square.visible = true
  if square.flagged then
    square.flagged = false
  end
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
    for _, bustedSquare in pairs(squares) do
      if not bustedSquare.visible then
        bustedSquare.visible = true
      end
    end
    GameState = GameStates.LOST
  end
end

local function HandleMenuClick()
  for _, button in ipairs(buttons) do
    if withinBoundingBox(mouseX, mouseY, button) then
      percentageMines = button.difficulty
      NewBoard()
      GameState = GameStates.PLAYING
    end
  end
end

local function HandleGameClick(button)
  if button == 1 then
    for _, square in pairs(squares) do
      if withinBoundingBox(mouseX, mouseY, square) and not square.flagged then
        processSquare(square)
      end
    end
  end
  if button == 2 then
    for _, square in pairs(squares) do
      if withinBoundingBox(mouseX, mouseY, square) then
        if not square.visible then
          square.flagged = not square.flagged
        end
        if square.content == "#" then
          print("Mine found")
        else
          print("No mine here")
        end
      end
    end
    numberOfSquaresFlagged = 0
    for _, square in pairs(squares) do
      if square.flagged then
        numberOfSquaresFlagged = numberOfSquaresFlagged + 1
      end
    end
  end
  if numberOfSquaresFlagged == numberOfBombs then
    local allMinesFlagged = true
    for _, square in pairs(squares) do
      if square.content == "#" and not square.flagged then
        allMinesFlagged = false
        break
      end
    end
    if allMinesFlagged then
      GameState = GameStates.WON
    end
  end
end

function love.mousepressed(_, _, button)
  if GameState == GameStates.PLAYING then
    HandleGameClick(button)
  elseif GameState == GameStates.LOST or GameState == GameStates.WON then
    GameState = GameStates.MENU
  elseif GameState == GameStates.MENU then
    HandleMenuClick()
  end
end

function love.keypressed(key)
  if key == "escape" then
    GameState = GameStates.MENU
  end
end

function love.draw()
  if GameState == GameStates.PLAYING then
    DrawFunctions.DrawPlayingScreen(squares, numberOfBombs, numberOfSquaresFlagged)
  elseif GameState == GameStates.LOST then
    DrawFunctions.DrawPlayingScreen(squares, numberOfBombs, numberOfSquaresFlagged)
    DrawFunctions.DrawLostOverlayScreen()
  elseif GameState == GameStates.WON then
    DrawFunctions.DrawPlayingScreen(squares, numberOfBombs, numberOfSquaresFlagged)
    DrawFunctions.DrawWonOverlayScreen()
  elseif GameState == GameStates.MENU then
    DrawFunctions.DrawMenuScreen()
  end
end