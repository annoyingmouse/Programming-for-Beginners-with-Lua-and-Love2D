WordsToGuess = {
  {"a", "p", "p", "l", "e"},
  {"h", "o", "r", "i", "z", "o", "n"},
  {"c", "o", "m", "p", "u", "t", "e", "r"},
  {"m", "u", "s", "i", "c"},
  {"l", "o", "v", "e"},
  {"s", "p", "a", "c", "e"},
  {"t", "e", "c", "h", "n", "o", "l", "o", "g", "y"},
  {"i", "n", "t", "e", "r", "n", "e", "t"},
  {"d", "e", "v", "e", "l", "o", "p", "m", "e", "n", "t"},
  {"a", "r", "t", "i", "f", "i", "c", "i", "a", "l"},
}

function love.load()
  for i, v in ipairs(WordsToGuess[1]) do
    print(i..v)
  end
end


function love.update()

end

function love.draw()
end