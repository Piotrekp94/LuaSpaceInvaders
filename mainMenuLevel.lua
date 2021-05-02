require("level")
mainMenuLevel = level:new()

function mainMenuLevel:draw()
    love.graphics.printf("Start", 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")
    love.graphics.printf("Highscores", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    love.graphics.printf("Exit", 0, love.graphics.getHeight() / 3 * 2, love.graphics.getWidth(), "center")
end
