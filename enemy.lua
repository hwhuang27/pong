Enemy = Object:extend()

function Enemy:new()
    local window_width = love.graphics.getWidth()
    self.x = window_width - 30
    self.y = 250
    self.width = 10
    self.height = 80
    self.speed = 420
end

function Enemy:update(dt, ball)
--    if love.keyboard.isDown("up") then
--        self.y = self.y - self.speed * dt
--    elseif love.keyboard.isDown("down") then
--        self.y = self.y + self.speed * dt
--    end
    
    local center = self.y + (self.height/2)
    if(center - 4 > ball.y) then
        self.y = self.y - self.speed * dt
    elseif (center + 4 < ball.y) then
        self.y = self.y + self.speed * dt
    else
        self.y = self.y
    end
    
    if self.y < 10 then
        self.y = 10
    elseif self.y + self.height > window_height - 10 then
        self.y = window_height - self.height - 10
    end
end

function Enemy:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end