Enemy = Object:extend()

function Enemy:new()
    local window_width = love.graphics.getWidth()
    self.x = window_width - 30
    self.y = 250
    self.width = 10
    self.height = 70
    self.speed = 500
end

function Enemy:update(dt)
    if love.keyboard.isDown("up") then
        self.y = self.y - self.speed * dt
    elseif love.keyboard.isDown("down") then
        self.y = self.y + self.speed * dt
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