local function withinBoundingBox(x, y, box)
  return x >= box.xMin and x <= box.xMax and y >= box.yMin and y <= box.yMax
end

return withinBoundingBox