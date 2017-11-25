-- declare shorthand newQuad
local q = love.graphics.newQuad

-- stores all possible quads
local quads = {}

-- populate the newly created table with quads
quads["kramer/walk-1"] = q(0, 0, 20, 33, 100, 33)
quads["kramer/walk-2"] = q(25, 0, 20, 33, 100, 33)
quads["kramer/walk-3"] = q(50, 0, 20, 33, 100, 33)
quads["kramer/walk-4"] = q(75, 0, 20, 33, 100, 33)

return quads
