-- declare shorthand newQuad
local quad = love.graphics.newQuad

-- stores all possible quads
local g = {}

-- populate the newly created table with quads
g["kramer/walk-1"] = quad(0, 0, 20, 33, 100, 33)
g["kramer/walk-2"] = quad(25, 0, 20, 33, 100, 33)
g["kramer/walk-3"] = quad(50, 0, 20, 33, 100, 33)
g["kramer/walk-4"] = quad(75, 0, 20, 33, 100, 33)
g["countryside/grass"] = quad(0, 0, 32, 32, 64, 64)
g["countryside/box"] = quad(32, 0, 32, 32, 64, 64)
g["countryside/flowers"] = quad(0, 32, 32, 32, 64, 64)
g["countryside/boxtop"] = quad(32, 32, 32, 32, 64, 64)

-- makes referencing specific frames easier
return {
  kramer = {
    walk = {
      frames = {
        g["kramer/walk-1"],
        g["kramer/walk-2"],
        g["kramer/walk-3"],
        g["kramer/walk-4"]
      }
    },
    moonwalk = {
      frames = {
        g["kramer/walk-4"],
        g["kramer/walk-3"],
        g["kramer/walk-2"],
        g["kramer/walk-1"]
      }
    }
  },
  _countryside = {
    g["countryside/grass"],
    g["countryside/box"],
    g["countryside/flowers"],
    g["countryside/boxtop"]
  }
}
