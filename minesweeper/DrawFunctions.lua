local buttons = require("MenuButtons")
local colours = require("Colours")
local love = require("love")

local SmallFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 18)
local MediumFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 24)
-- local LargeFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 36)
local HugeFont = love.graphics.newFont("fonts/TT Octosquares Trial Expanded Black.ttf", 72)

local DrawFunctions = {}

DrawFunctions.DrawMenuScreen = function()
  love.graphics.setFont(HugeFont)
  love.graphics.printf(
    "Minesweeper",
    0,
    (love.graphics.getHeight() / 2 - (HugeFont and HugeFont:getHeight() or 0) / 2) - 100,
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

DrawFunctions.DrawLostOverlayScreen = function()
  love.graphics.setColor(colours.TRANSPARENT_BLACK)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(colours.RED)
  love.graphics.setFont(HugeFont)
  love.graphics.printf(
    "You Lost!",
    0,
    (love.graphics.getHeight() / 2 - (HugeFont and HugeFont:getHeight() or 0) / 2) - 50,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.setColor(colours.WHITE)
  love.graphics.setFont(MediumFont)
  love.graphics.printf(
    "Click to try again",
    0,
    (love.graphics.getHeight() / 2 - (MediumFont and MediumFont:getHeight() or 0) / 2) + 20,
    love.graphics.getWidth(),
    "center"
  )
end

DrawFunctions.DrawWonOverlayScreen = function()
  love.graphics.setColor(colours.TRANSPARENT_BLACK)
  love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(colours.GREEN)
  love.graphics.setFont(HugeFont)
  love.graphics.printf(
    "You Won!",
    0,
    (love.graphics.getHeight() / 2 - (HugeFont and HugeFont:getHeight() or 0) / 2) - 50,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.setColor(colours.WHITE)
  love.graphics.setFont(MediumFont)
  love.graphics.printf(
    "Click to play again",
    0,
    (love.graphics.getHeight() / 2 - (MediumFont and MediumFont:getHeight() or 0) / 2) + 20,
    love.graphics.getWidth(),
    "center"
  )
end

DrawFunctions.DrawPlayingScreen = function(squares, numberOfBombs, numberOfSquaresFlagged)
  for _, square in pairs(squares) do
    square:draw()
  end
  love.graphics.setFont(MediumFont)
  love.graphics.setColor(colours.GREY)
  love.graphics.printf(
    "Mines: " .. numberOfBombs - numberOfSquaresFlagged,
    0,
    love.graphics.getHeight() - 35,
    love.graphics.getWidth(),
    "center"
  )
  love.graphics.setColor(colours.WHITE)
end

return DrawFunctions