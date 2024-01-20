io.stdout:setvbuf("no")

require "utility"

function love.load()
    Object = require "classic"
    require "player"
    require "enemy"
    require "ball"
    require "wall"
    
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    playerScore = 0
    enemyScore = 0
    
    ceiling = Wall(0, 0)
    floor = Wall(0, window_height - 10)
    player = Player()
    enemy = Enemy()
    ball = Ball()
    
    blip = love.audio.newSource("sfx/blip.wav", "static")
    goal = love.audio.newSource("sfx/goal.wav", "static")
    fail = love.audio.newSource("sfx/fail.wav", "static")
end

function love.update(dt)
    player:update(dt)
    enemy:update(dt, ball)
    ball:update(dt)
    
    ball:checkWallCollision(ceiling)
    ball:checkWallCollision(floor)
    
    ball:checkCollision(player)
    ball:checkCollision(enemy)
    
    if ball.x < 0 then
        enemyScore = enemyScore + 1
        enemy:decreaseSpeed()
        fail:play()
        ball:reset()
    elseif ball.x > window_width then
        playerScore = playerScore + 1
        enemy:increaseSpeed()
        goal:play()
        ball:reset()
    end
end

function love.draw()
    player:draw()
    enemy:draw()
    ball:draw()
    
    ceiling:draw()
    floor:draw()
    
    love.graphics.print('Score: ' .. playerScore, 20, 20, 0, 2, 2)
    love.graphics.print('Score: ' .. enemyScore, window_width - 120, 20, 0, 2, 2)
end


