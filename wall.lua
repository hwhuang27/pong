Wall = Object:extend()

function Wall:new(x, y)
    self.x = x
    self.y = y
    self.width = love.graphics.getWidth()
    self.height = 10
end

function Wall:draw()
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
