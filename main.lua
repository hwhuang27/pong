io.stdout:setvbuf("no")

function normalize(val, min, max)
    return (val - min) / (max - min)
end

print(normalize(-20, -40, 40))

function love.load()
    Object = require "classic"
    require "player"
    require "enemy"
    require "ball"
    require "wall"
    
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    
    player = Player()
    enemy = Enemy()
    ball = Ball()
    
    ceiling = Wall(0, 0)
    floor = Wall(0, window_height - 10)
    
end

function love.update(dt)
    player:update(dt)
    enemy:update(dt)
    ball:update(dt)
    
    ball:checkWallCollision(ceiling)
    ball:checkWallCollision(floor)
    
    ball:checkCollision(player)
    ball:checkCollision(enemy)
end

function love.draw()
    player:draw()
    enemy:draw()
    ball:draw()

    ceiling:draw()
    floor:draw()
end
