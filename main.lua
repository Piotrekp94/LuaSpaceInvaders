require("player")
require("enemies")
require("levelManager")
score = 0
bullets = {}
bullets_generation_tick = 30


function love.load()
    love.graphics.setNewFont(30)
    levelManager.loadStartLevel()
    player.image = love.graphics.newImage('images/player.png')
    player.explose_shoot = love.audio.newSource('sounds/shoot.mp3', 'static')
    music = love.audio.newSource('sounds/music.mp3', 'static')
    player_shoot_sound = love.audio.newSource('sounds/shoot.mp3', 'static')
    music:setLooping(true)
--    love.audio.play(music)
end

function love.draw()
    levelManager.draw()
    love.graphics.print(score, 5, 5)
    love.graphics.setColor(1, 1, 1)
    for it, bullet in pairs(bullets) do
        love.graphics.rectangle("fill", bullet.x, bullet.y, 5, 20)
    end
    love.graphics.draw(player.image, player.x, (love.graphics.getHeight() * 0.95), 0, 0.3)
end

function love.update()
    if levelManager.isMainMenu == true then
        print("MainManu")
    else
--        if table.getn(enemies_list) == 0 then
--            levelManager.nextLevel()
--        end

        if love.keyboard.isDown('right') then
            if player.x > 750 then
                player.x = 750
            end
            player.x = player.x + 5
        end
        if love.keyboard.isDown('left') then
            if player.x < 10 then
                player.x = 10
            end
            player.x = player.x - 5
        end
        if love.keyboard.isDown('space') then
            player.shoot()
        end
        if love.keyboard.isDown('q') then
            love.event.quit()
        end

        for it, bullet in pairs(bullets) do
            bullet.y = bullet.y - 5
        end

        bullets_generation_tick = bullets_generation_tick - 1
    end
end