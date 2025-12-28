local function getAdjacentSquares(square)
  local letter, number = string.match(square, "([A-Z]+)(%d+)")
  local adjacentSquares = {}
  -- Check all 8 adjacent squares
  if string.byte(letter) ~= string.byte("A") then
    table.insert(adjacentSquares, string.char(string.byte(letter) - 1) .. number)
  end
  if string.byte(letter) ~= string.byte("T") then
    table.insert(adjacentSquares, string.char(string.byte(letter) + 1) .. number)
  end
  if tonumber(number) ~= 1 then
    table.insert(adjacentSquares, letter .. tostring(tonumber(number) - 1))
  end
  if tonumber(number) ~= 14 then
    table.insert(adjacentSquares, letter .. tostring(tonumber(number) + 1))
  end
  -- Diagonals
  if string.byte(letter) ~= string.byte("A") and tonumber(number) ~= 1 then
    table.insert(adjacentSquares, string.char(string.byte(letter) - 1) .. tostring(tonumber(number) - 1))
  end
  if string.byte(letter) ~= string.byte("T") and tonumber(number) ~= 1 then
    table.insert(adjacentSquares, string.char(string.byte(letter) + 1) .. tostring(tonumber(number) - 1))
  end
  if string.byte(letter) ~= string.byte("A") and tonumber(number) ~= 14 then
    table.insert(adjacentSquares, string.char(string.byte(letter) - 1) .. tostring(tonumber(number) + 1))
  end
  if string.byte(letter) ~= string.byte("T") and tonumber(number) ~= 14 then
    table.insert(adjacentSquares, string.char(string.byte(letter) + 1) .. tostring(tonumber(number) + 1))
  end
  return adjacentSquares
end

return getAdjacentSquares