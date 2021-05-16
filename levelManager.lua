require("enemy")
require("gameLevel")

levelManager = {}
isMainMenu = false
currentLevel = {}

function levelManager:loadStartLevel()
    isMainMenu = true
    currentLevel = gameLevel:new{}
end

function levelManager:loadNextLevel()
    isMainMenu = false
    currentLevel = levelGenerator.getLevel(0)
end


function levelManager:draw()
    currentLevel:draw()
end

function levelManager:tick()
    currentLevel:tick()
end
