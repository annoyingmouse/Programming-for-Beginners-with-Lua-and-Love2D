local love = require("love")
local checkNeighbors = require('CheckNeighbors')
local getAdjacentSquares = require('GetAdjacentSquares')
local squares = require('squares').squares
local percentageMines = 10

local function NewBoard(font)
  for square in pairs(squares) do
    squares[square].font = font
    if math.random(100) <= percentageMines then
        squares[square].content = "#"
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
  local font = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 24)
  math.randomseed(os.time())
  NewBoard(font)
end

function love.update(dt)

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

function love.mousepressed(x, y, button)
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


function love.draw()
    for _, square in pairs(squares) do
        square:draw()
    end
end