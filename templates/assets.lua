-- declare shorthand newQuad
local quad = love.graphics.newQuad

-- makes referencing specific animations easier
local character = {}

-- stores all assets
local assets = {
  character = {
    unarmed = {
      idle = {
        frames = {
          quad(0, 377, 126, 90, 705, 467)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(0, 0, 232, 372, 705, 467)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(0, 0, 232, 372, 705, 467),
          quad(237, 0, 232, 372, 705, 467),
          quad(473, 0, 232, 372, 705, 467),
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1, 2, 2, 3, 3, 3, 3, 2, 1},
        interval = 0.05
      }
    },
    animations = character
  }
}

-- populate the newly created tables with animation references
character["unarmed-idle"] = assets.character.unarmed.idle
character["sword-shield-idle"] = assets.character.sword_shield.idle
character["sword-shield-stab"] = assets.character.sword_shield.stab

return assets
