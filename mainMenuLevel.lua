require("level")
mainMenuLevel = level:new()

function mainMenuLevel:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.position = 0
    return o
end

function mainMenuLevel:handleInput(key)
    if key == 'up' and self.position > 0  then
        self.position = self.position - 1
    end

    if key == 'down' and self.position < 2 then
        self.position = self.position + 1
    end

    if key == 'return' and self.position == 0 then
        self.isFinished = true
    end
    if key == 'return' and self.position == 2 then
        love.event.quit()
    end
end

function mainMenuLevel:draw()
    if self.position == 0 then
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.printf("Start", 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")

    else
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.printf("Start", 0, love.graphics.getHeight() / 3, love.graphics.getWidth(), "center")
    end
    if self.position == 1 then
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.printf("Highscores", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    else
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.printf("Highscores", 0, love.graphics.getHeight() / 2, love.graphics.getWidth(), "center")
    end
    if self.position == 2 then
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.printf("Exit", 0, love.graphics.getHeight() / 3 * 2, love.graphics.getWidth(), "center")
    else
        love.graphics.setColor(0, 255, 0, 255)
        love.graphics.printf("Exit", 0, love.graphics.getHeight() / 3 * 2, love.graphics.getWidth(), "center")
    end
    love.graphics.setColor(0, 255, 0, 255)
end

