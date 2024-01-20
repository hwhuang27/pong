function normalize(val, min, max)
    return (val - min) / (max - min)
end

function rsign() 
    return love.math.random(2) == 2 and 1 or -1 
end