local love = require("love")
local Enemy = require("Enemy")
local Player = require("Player")
local Button = require("Button")
local FPS = require("FPS")

math.randomseed(os.time())

local game = {
  difficulty = 1,
  state = {
    menu = true,
    paused = false,
    running = false,
    ended = false
  }
}

local buttons = {menuState = {}}

local enemies = {}

local player

function love.load()
  love.window.setTitle("Save the Ball!")
  love.window.setMode(800, 600)
  love.mouse.setVisible(false)
  player = Player:new()
  buttons.menuState.playGame = Button:new(
    "Play Game",
    10,
    20,
    100,
    50,
    function()
      game.state.menu = false
      game.state.running = true
      table.insert(enemies, Enemy:new())
    end
  )
  buttons.menuState.settings = Button:new(
    "Settings",
    10,
    80,
    100,
    50,
    function()
      print("Settings button clicked")
    end
  )
  buttons.menuState.exitGame = Button:new(
    "Exit Game",
    10,
    140,
    100,
    50,
    function()
      love.event.quit()
    end
  )
end

function love.update(dt)
  player:update(game.state.running)
  buttons.menuState.playGame:update(love.mouse.getX(), love.mouse.getY(), love.mouse.isDown(1))
  buttons.menuState.settings:update(love.mouse.getX(), love.mouse.getY(), love.mouse.isDown(1))
  buttons.menuState.exitGame:update(love.mouse.getX(), love.mouse.getY(), love.mouse.isDown(1))
  for
   _, enemy in ipairs(enemies) do
    enemy:update(player.x, player.y, dt)
  end
end

function love.draw()
  FPS()
  if game.state.running then
    for _, enemy in ipairs(enemies) do
      enemy:draw(10, 20, 10, 20)
    end
  end
  if game.state.menu then
    buttons.menuState.playGame:draw()
    buttons.menuState.settings:draw()
    buttons.menuState.exitGame:draw()
  end
  player:draw(game.state.running)
end