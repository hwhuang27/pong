Ball = Object:extend()

function Ball:new()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    self.x = width/2
    self.y = height/2
    self.size = 10
    self.speed = 300
    
    local angle = math.atan2(50 - 100,125 - 100)
--    self.cos = math.cos(angle)
--    self.sin = math.sin(angle)
    self.cos = 1
    self.sin = 0
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
            -- invert sin to bounce off walls
            self.sin = -self.sin
    end
    
end

function Ball:checkCollision(obj)
    local width = love.graphics.getWidth()
     
    local self_left = self.x
    local self_right = self.x + self.size
    local self_top = self.y
    local self_bot = self.y + self.size
    
    local obj_left = obj.x
    local obj_right = obj.x + obj.width
    local obj_top = obj.y
    local obj_bot = obj.y + obj.height
    
    -- if collision detected
    if self_right > obj_left
        and self_left < obj_right
        and self_bot > obj_top
        and self_top < obj_bot then
        
            local ball_impact = self.y + (self.size/2)
            local paddle_impact = obj.y + (obj.height/2)
            local impact_diff = paddle_impact - ball_impact
            
            -- change cos / sine depending on where it impacts
            
            if self.x < width/2 and impact_diff < 0 then
                self.x = obj.x + obj.width + 1
                -- larger number = greater angle
                
                -- do something
            elseif self.x < width/2 and impact_diff > 0 then
                self.x = obj.x + obj.width + 1
                -- do something
            elseif self.x > width/2 and impact_diff < 0 then
                self.x = obj.x - obj.width + 1
                -- do something
            elseif self.x > width/2 and impact_diff > 0 then
                self.x = obj.x - obj.width + 1
                -- do something
            end
                
            -- change ball direction
            self.speed = -self.speed
            

            
            
    end
            
end

