Ball = Object:extend()

function Ball:new()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    
    self.x = width/2
    self.y = love.math.random(height/2 - 100, height/2 + 100)
    self.size = 10
    self.speed = 300
    
    self.cos = (0.866 + (love.math.random(1, 134)/1000)) * rsign()
    self.sin = -0.5 + (love.math.random(1, 100)/100)
end

function Ball:update(dt)
    self.x = self.x + self.speed * self.cos * dt
    self.y = self.y + self.speed * self.sin * dt
end

function Ball:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.size, self.size)
end

function Ball:reset()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    self.x = width/2
    self.y = love.math.random(height/2 - 50, height/2 + 50)
    self.speed = 300
    self.cos = (0.866 + (love.math.random(1, 134)/1000)) * rsign()
    self.sin = -0.5 + (love.math.random(1, 100)/100)
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
            
            -- prevent collision from 'sticking'
            local height = love.graphics.getHeight()
            if self.y < height/2 then
                self.y = obj.y + obj.height + 1
            elseif self.y > height/2 then
                self.y = obj.y - obj.height - 1
            end
            
            -- invert sin to bounce off walls
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
            
            local width = love.graphics.getWidth()
            local ball_impact = self.y + (self.size/2)
            local paddle_impact = obj.y + (obj.height/2)
            local impact_diff = paddle_impact - ball_impact
    
            if obj:is(Player) then
                self.x = obj.x + obj.width + 1 
                if impact_diff > 0 then
                    local normalized = normalize(impact_diff, 0, 40)
                    self.sin = 0 - (0.707 * normalized)
                    self.cos = 1 - (0.293 * normalized)
                elseif impact_diff < 0 then
                    local normalized = normalize(impact_diff, 0, -40)
                    self.sin = 0 + (0.707 * normalized)
                    self.cos = 1 - (0.293 * normalized)
                end

            elseif obj:is(Enemy) then
                self.x = obj.x - obj.width - 1
                if impact_diff > 0 then
                    local normalized = normalize(impact_diff, 0, 40)
                    self.sin = 0 + (0.707 * normalized)
                    self.cos = 1 - (0.293 * normalized)
                elseif impact_diff < 0 then
                    local normalized = normalize(impact_diff, 0, -40)
                    self.sin = 0 - (0.707 * normalized)
                    self.cos = 1 - (0.293 * normalized)
                end
            end

            -- change ball direction and cap max at 800
            self.speed = -self.speed * 1.1
            if self.speed > 800 then
                self.speed = 800
            elseif self.speed < -800 then
                self.speed = -800
            end
            
    end
end

