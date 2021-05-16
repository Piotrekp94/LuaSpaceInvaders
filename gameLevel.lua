require("level")
gameLevel = level:new()

function gameLevel:new(o)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self.position = 0
    self.enemies_list = self:generateEnemies()
    self.movingCounter = 0
    self.direction = 1
    return o
end

function gameLevel:generateEnemies()
    enemies_list = {}
    for i = 0, 4, 1
    do
        for j = 0, 4, 1
        do
            enemy = {}
            enemy.x = (love.graphics.getWidth() / 5) * i + 50
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
    if (#self.enemies_list <= 0) then
        love.graphics.print("YOU WIN", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 30)
    else
        for it, enemy in pairs(self.enemies_list) do
            love.graphics.draw(enemy.image, enemy.x, enemy.y, 0, 0.3)
        end
        love.graphics.draw(player.image, player.x, player.y, 0, 0.3)
        for it, bullet in pairs(bullets) do
            love.graphics.rectangle("fill", bullet.x, bullet.y, 5, 20)
        end
        love.graphics.print(#self.enemies_list, 55, 5)

    end
end

function gameLevel:tick()
    self:verifyCollisions()
    if (self.movingCounter < 75) then
        for it, enemy in pairs(self.enemies_list) do
            enemy.x = enemy.x + 1 * self.direction
        end
        self.movingCounter = self.movingCounter + 1
    end
    if (self.movingCounter >= 75) then
        self.movingCounter = 0
        self.direction = self.direction * -1
        for it, enemy in pairs(self.enemies_list) do
            enemy.y = enemy.y + 3
        end
    end
end

function gameLevel:verifyCollisions()
    for it, enemy in pairs(self.enemies_list) do
        for it2, bullet in pairs(bullets) do
            if collisionBE(enemy, bullet) then
                table.remove(self.enemies_list, it)
                table.remove(bullets, it2)
                break
            end
        end
    end
    for it, enemy in pairs(self.enemies_list) do
        if (collision(player, enemy)) then

            love.event.quit()
        end
    end
end

function collisionBE(enemy, bullet)
    bw, bh = enemy.image:getDimensions()

    return bullet.x < (enemy.x + bw) and
            enemy.x < (bullet.x) and
            bullet.y < (enemy.y + bh) and
            enemy.y < (bullet.y)
end

function collision(a, b)
    aw, ah = a.image:getDimensions()
    bw, bh = b.image:getDimensions()

    return a.x < (b.x + bw) and
            b.x < (a.x + aw) and
            a.y < (b.y + bh) and
            b.y < (a.y + ah)
end