local getAdjacentSquares = require('GetAdjacentSquares')

local function checkNeighbors(square, squares)
  local adjacentMines = 0
  local adjacentSquares = getAdjacentSquares(square)
  for _, adjacentSquare in ipairs(adjacentSquares) do
    if squares[adjacentSquare] and squares[adjacentSquare].content == "#" then
      adjacentMines = adjacentMines + 1
    end
  end
  -- Check all 8 adjacent squares
  -- if string.byte(letter) ~= string.byte("A") then
  --   local leftSquare = string.char(string.byte(letter) - 1) .. number
  --   if squares[leftSquare] and squares[leftSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if string.byte(letter) ~= string.byte("U") then
  --   local rightSquare = string.char(string.byte(letter) + 1) .. number
  --   if squares[rightSquare] and squares[rightSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if tonumber(number) ~= 1 then
  --   local topSquare = letter .. tostring(tonumber(number) - 1)
  --   if squares[topSquare] and squares[topSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if tonumber(number) ~= 14 then
  --   local bottomSquare = letter .. tostring(tonumber(number) + 1)
  --   if squares[bottomSquare] and squares[bottomSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- -- Diagonals
  -- if string.byte(letter) ~= string.byte("A") and tonumber(number) ~= 1 then
  --   local topLeftSquare = string.char(string.byte(letter) - 1) .. tostring(tonumber(number) - 1)
  --   if squares[topLeftSquare] and squares[topLeftSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if string.byte(letter) ~= string.byte("U") and tonumber(number) ~= 1 then
  --   local topRightSquare = string.char(string.byte(letter) + 1) .. tostring(tonumber(number) - 1)
  --   if squares[topRightSquare] and squares[topRightSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if string.byte(letter) ~= string.byte("A") and tonumber(number) ~= 14 then
  --   local bottomLeftSquare = string.char(string.byte(letter) - 1) .. tostring(tonumber(number) + 1)
  --   if squares[bottomLeftSquare] and squares[bottomLeftSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  -- if string.byte(letter) ~= string.byte("U") and tonumber(number) ~= 14 then
  --   local bottomRightSquare = string.char(string.byte(letter) + 1) .. tostring(tonumber(number) + 1)
  --   if squares[bottomRightSquare] and squares[bottomRightSquare].content == "#" then
  --     adjacentMines = adjacentMines + 1
  --   end
  -- end
  return adjacentMines
end

return checkNeighbors