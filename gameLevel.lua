require("level")
gameLevel = level:new()

function gameLevel:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.position = 0
    self.enemies_list = self:generateEnemies()

    return o
end

function gameLevel:generateEnemies()
    enemies_list = {}
    for i = 0, 5, 1
    do
        for j = 0, 4, 1
        do
            enemy = {}
            enemy.x = (love.graphics.getWidth() / 5) * i  + 50
            enemy.y = 50 * j
            enemy.image = love.graphics.newImage('images/invader.png')
            table.insert(enemies_list, enemy)
        end
    end
    return enemies_list
end

function gameLevel:handleInput(key)
end

function gameLevel:draw()
    for it, enemy in pairs(self.enemies_list) do
        love.graphics.draw(enemy.image, enemy.x, enemy.y, 0, 0.3)
    end
        love.graphics.draw(player.image, player.x, (love.graphics.getHeight() * 0.95), 0, 0.3)
    for it, bullet in pairs(bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, 5, 20)
    end

end