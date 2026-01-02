_G.love = require("love")
local Jack = require("Jack")

function love.load()
  _G.jack = Jack:new(0, 0, "sprites/spritesheet.png", 8)
end

function love.update(dt)
  jack:update(dt)
end

function love.draw()
  jack:draw()
end