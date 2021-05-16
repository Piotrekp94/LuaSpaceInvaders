require("player")
require("levelManager")
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
    love.audio.play(music)
end

function love.draw()
    levelManager:draw()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" or key == "q" then
        love.event.quit()
    end
end

function love.update()
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

    levelManager.tick()


    bullets_generation_tick = bullets_generation_tick - 1
end