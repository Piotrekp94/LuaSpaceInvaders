player = {}
player.x = 100
player.y = love.graphics.getHeight() * 0.95

function player:shoot()
    if bullets_generation_tick <= 0 then
        bullets_generation_tick = 30
        bullet = {}
        bullet.x = player.x + 15
        bullet.y = 520
        table.insert(bullets, bullet)
        --        love.audio.play(player_shoot_sound)
    end
end


