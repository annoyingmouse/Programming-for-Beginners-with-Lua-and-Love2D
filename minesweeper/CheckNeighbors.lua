local getAdjacentSquares = require('GetAdjacentSquares')

local function checkNeighbors(square, squares)
  local adjacentMines = 0
  local adjacentSquares = getAdjacentSquares(square)
  for _, adjacentSquare in ipairs(adjacentSquares) do
    if squares[adjacentSquare] and squares[adjacentSquare].content == "#" then
      adjacentMines = adjacentMines + 1
    end
  end
  return adjacentMines
end

return checkNeighbors