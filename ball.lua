Ball = Object:extend()

function Ball:new()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
--    self.x = width/2
--    self.y = height/2
    self.x = 100
    self.y = 100
    self.size = 10
    self.speed = 200
    
    local angle = math.atan2(50 - 100,125 - 100)
    self.cos = math.cos(angle)
    self.sin = math.sin(angle)
    
end

function Ball:update(dt)
    
    self.x = self.x + self.speed * self.cos * dt
    self.y = self.y + self.speed * self.sin * dt
    
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Ball:checkWallCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.size
    local self_top = self.y
    local self_bot = self.y + self.size
    
    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bot = obj.y + obj.height
    
    if self_right > obj_left
        and self_left < obj_right
        and self_bot > obj_top
        and self_top < obj_bot then
            self.sin = -self.sin
    end
    
end

function Ball:checkCollision(obj)
    local self_left = self.x
    local self_right = self.x + self.size
    local self_top = self.y
    local self_bot = self.y + self.size
    
    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bot = obj.y + obj.height
    
    if self_right > obj_left
        and self_left < obj_right
        and self_bot > obj_top
        and self_top < obj_bot then
            self.speed = -self.speed
    end
            
end