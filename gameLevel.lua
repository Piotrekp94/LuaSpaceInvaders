require("level")
gameLevel = level:new()

playerRatio = 0.3
enemyRatio = 0.3
endgame = false
enemyBullets = {}
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

    if (endGame) then
        love.graphics.print("YOU LOST", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 30)
    else
        if (#self.enemies_list <= 0) then
            love.graphics.print("YOU WIN", love.graphics.getWidth() / 2 - 50, love.graphics.getHeight() / 2 - 30)
        else
            for it, enemy in pairs(self.enemies_list) do
                love.graphics.draw(enemy.image, enemy.x, enemy.y, 0, enemyRatio)
            end
            love.graphics.draw(player.image, player.x, player.y, 0, playerRatio)
            for it, bullet in pairs(bullets) do
                love.graphics.rectangle("fill", bullet.x, bullet.y, 5, 20)
            end
            for it, bullet in pairs(enemyBullets) do
                love.graphics.rectangle("fill", bullet.x, bullet.y, 5, 20)
            end
            love.graphics.print(#self.enemies_list, 55, 5)
        end
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
    for it, enemy in pairs(self.enemies_list) do
        number = love.math.random(0, 20000)
        if (number < 5) then
            spawnEnemyBullet(enemy)
        end
    end
    for it, bullet in pairs(enemyBullets) do
        bullet.y = bullet.y + 5
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
        if (collisionPE(player, enemy)) then
            endGame = true
        end
    end
    for it, bullet in pairs(enemyBullets) do
        if (collisionBP(player, bullet)) then
            endGame = true
        end
    end
end

function collisionBE(enemy, bullet)
    bw, bh = enemy.image:getDimensions()
    bw = bw * enemyRatio
    bh = bh * enemyRatio
    return bullet.x < (enemy.x + bw) and
            enemy.x < (bullet.x) and
            bullet.y < (enemy.y + bh) and
            enemy.y < (bullet.y)
end

function collisionBP(player, bullet)
    bw, bh = player.image:getDimensions()
    bw = bw * playerRatio
    bh = bh * playerRatio
    return bullet.x < (player.x + bw) and
            player.x < (bullet.x) and
            bullet.y < (player.y + bh) and
            player.y < (bullet.y)
end

function collisionPE(player, enemy)
    playerw, playerh = player.image:getDimensions()
    enemyw, enemyh = enemy.image:getDimensions()

    playerw = playerw * playerRatio
    playerh = playerh * playerRatio

    enemyw = enemyw * enemyRatio
    enemyh = enemyh * enemyRatio
    return player.x < (enemy.x + enemyw) and
            enemy.x < (player.x + playerw) and
            player.y < (enemy.y + enemyh) and
            enemy.y < (player.y + playerh)
end

function spawnEnemyBullet(enemy)
    bullet = {}
    bullet.x = enemy.x + 15
    bullet.y = enemy.y
    table.insert(enemyBullets, bullet)
end