function DoubleValueAndGiveBack(number)
  local doubled = number * 2
  return doubled
end

function love.load()
  A = 5
  print("The starting value is: " .. A)
  A = DoubleValueAndGiveBack(A)
  print("The value is now: " .. A .. " after doubling.")
end

function IncrementA()
  
end

function love.update()

end

function love.draw()
  love.graphics.printf(A, 0, 0, 100, "left")
end