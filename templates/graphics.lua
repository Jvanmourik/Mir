-- declare shorthand newQuad
local quad = love.graphics.newQuad

-- stores all possible quads
local frames = {}

-- populate the newly created table with quads
frames["kramer/walk-1"] = quad(0, 0, 20, 33, 100, 33)
frames["kramer/walk-2"] = quad(25, 0, 20, 33, 100, 33)
frames["kramer/walk-3"] = quad(50, 0, 20, 33, 100, 33)
frames["kramer/walk-4"] = quad(75, 0, 20, 33, 100, 33)
frames["redenemy/sprite-1"] = quad(0, 0, 35, 34, 68, 34)
frames["redenemy/sprite-2"] = quad(35, 0, 34, 34, 68, 34)
frames["redenemyattack/sprite-1"] = quad(0, 0, 16, 16, 100, 33)
frames["redenemyattack/sprite-2"] = quad(16, 0, 16, 16, 100, 33)


-- makes referencing specific frames easier
return {
  redenemysprite = {
    shrink = {
      frames = {
        frames["redenemy/sprite-1"],
        frames["redenemy/sprite-2"]
      }
    }
  },
  kramer = {
    walk = {
      frames = {
        frames["kramer/walk-1"],
        frames["kramer/walk-2"],
        frames["kramer/walk-3"],
        frames["kramer/walk-4"]
      }
    },
    moonwalk = {
      frames = {
        frames["kramer/walk-4"],
        frames["kramer/walk-3"],
        frames["kramer/walk-2"],
        frames["kramer/walk-1"]
      }

    }
  }
}
