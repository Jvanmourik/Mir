-- declare shorthand newQuad
local q = love.graphics.newQuad

-- stores all possible quads
local quads = {}

-- populate the newly created table with quads
quads["assets/images/squirtle.png"] = q(0, 0, 38, 39, 46, 83)
quads["assets/images/pikachu.png"] = q(0, 39, 46, 44, 46, 83)

return quads
