-- declare shorthand newQuad
local quad = love.graphics.newQuad

local animations = {}

-- makes referencing specific frames easier
assets = {
  character = {
    unarmed = {
      idle = {
        frames = {
          quad(218, 389, 252, 180, 538, 744),
          quad(218, 389, 252, 180, 538, 744),
          quad(218, 389, 252, 180, 538, 744),
          quad(218, 389, 252, 180, 538, 744),
          quad(218, 389, 252, 180, 538, 744)
        },
        anchorX = 0.5,
        anchorY = 0.46,
        sequence = {1, 2, 3, 3, 3, 4, 5},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(218, 0, 320, 389, 538, 744),
          quad(218, 10, 320, 389, 538, 744),
          quad(218, 20, 320, 389, 538, 744),
          quad(218, 30, 320, 389, 538, 744)
        },
        anchorX = 0.7,
        anchorY = 0.47,
        sequence = {1, 2, 3, 4},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(0, 0, 218, 744, 538, 744),
          quad(10, 0, 218, 744, 538, 744),
          quad(20, 0, 218, 744, 538, 744)
        },
        anchorX = 0.35,
        anchorY = 0.36,
        sequence = {1, 2, 3},
        interval = 0.25
      }
    },
    animations = animations
  }
}

animations["unarmed-idle"] = assets.character.unarmed.idle
animations["sword-shield-idle"] = assets.character.sword_shield.idle
animations["sword-shield-stab"] = assets.character.sword_shield.stab

return assets
