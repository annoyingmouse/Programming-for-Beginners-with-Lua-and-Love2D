_G.love = require("love")
_G.Dump = require("Dump")
_G.processedData = {}
_G.runningTotal = 0

function love.load()
    local filename = "test.txt"
    if love.filesystem.getInfo(filename) then
        local contents = love.filesystem.read(filename)
        if contents then
            for line in contents:gmatch("[^\r\n]+") do
              -- %a matches the letter, %d+ matches one or more digits
              local dir, val = line:match("(%a)(%d+)")
              table.insert(_G.processedData, {
                  dir = dir,
                  val = tonumber(val) -- Convert string "68" to actual number 68
              })
              _G.runningTotal = _G.runningTotal + tonumber(val)
            end
        end
    else
        print("File not found.")
    end
    print(Dump(_G.processedData))
    print(#_G.processedData)
    print("Running Total:", _G.runningTotal)
    print("Total steps:", _G.runningTotal * #_G.processedData)
end

