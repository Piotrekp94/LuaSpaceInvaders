require("enemies")
require("mainMenuLevel")
levelManager = {}
isMainMenu = false
currentLevel = {}
function levelManager:loadStartLevel()
    isMainMenu = true
    currentLevel = mainMenuLevel:new{}
end


function levelManager:draw()
    currentLevel.draw()
end

