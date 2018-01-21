-- declare shorthand newQuad and newImage
local quad = love.graphics.newQuad
local image = love.graphics.newImage

-- makes referencing specific animations easier
local character = {}

-- stores all assets
local assets = {
  character = {
    atlas = image("assets/images/character.png"),
    unarmed = {
      idle = {
        frames = {
          quad(0, 377, 126, 90, 705, 493)
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
          quad(0, 0, 232, 372, 705, 493)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(0, 0, 232, 372, 705, 493),
          quad(237, 0, 232, 372, 705, 493),
          quad(473, 0, 232, 372, 705, 493)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1, 2, 2, 3, 3, 3, 3, 2, 1},
        interval = 0.05
      }
    },
    legs = {
      idle = {
        frames = {
          quad(136, 377, 70, 116, 705, 493)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(136, 377, 70, 116, 705, 493),
          quad(211, 377, 70, 116, 705, 493),
          quad(286, 377, 70, 116, 705, 493),
          quad(361, 377, 70, 116, 705, 493),
          quad(436, 377, 70, 116, 705, 493),
          quad(511, 377, 70, 116, 705, 493),
          quad(586, 377, 70, 116, 705, 493)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      }
    },
    animations = character
  },
  items = {
    atlas = image("assets/images/items.png"),
    regularSword = {
      frames = {
        quad(43, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    regularBow = {
      frames = {
        quad(22, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    regularDamageStaff = {
      frames = {
        quad(22, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    regularHealingStaff = {
      frames = {
        quad(22, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    bloodSword = {
      frames = {
        quad(1, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    arrow = {
      frames = {
        quad(64, 1, 19, 42, 84, 44)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  },
  boss = {
    atlas = image("assets/images/boss.png"),
    bossAsset = {
      frames = {
        quad(1, 1, 100, 100, 100, 100)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  }
}

-- populate the newly created tables with animation references
character["unarmed-idle"] = assets.character.unarmed.idle
character["sword-shield-idle"] = assets.character.sword_shield.idle
character["sword-shield-stab"] = assets.character.sword_shield.stab
character["legs-idle"] = assets.character.legs.idle
character["legs-walk"] = assets.character.legs.walk
heart = image("assets/images/heart.png")

return assets
