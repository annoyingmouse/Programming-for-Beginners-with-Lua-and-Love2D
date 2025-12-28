local function drawLines(sq, ScreenWidth, ScreenHeight)
    for i = 1, 14 do
        love.graphics.line(0, i * sq, ScreenWidth, i * sq)
    end

    for i = 1, 20 do
        love.graphics.line(i * sq, 0, i * sq, ScreenHeight - sq)
    end
end

return drawLines