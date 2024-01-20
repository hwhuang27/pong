Player = Object:extend()

function Player:new()
    self.x = 30
    self.y = 250
    self.width = 10
    self.height = 80
    self.speed = 500
end

function Player:update(dt)
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("s") or love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
    end
    
    if self.y < 10 then
        self.y = 10
    elseif self.y + self.height > window_height - 10 then
        self.y = window_height - self.height - 10
    end
end

function Player:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end