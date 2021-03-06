-- declare shorthand newQuad and newImage
local quad = love.graphics.newQuad
local image = love.graphics.newImage

-- makes referencing specific animations easier
local character = {}
local enemy = {}

-- stores all assets
local assets = {
  character = {
    atlas = image("assets/images/character.png"),
    unarmed = {
      idle = {
        frames = {
          quad(2, 2, 127, 76, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      },
      dash = {
        frames = {
          quad(123, 359, 117, 139, 242, 2094),
          quad(2, 500, 117, 139, 242, 2094),
          quad(121, 500, 117, 139, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    bow = {
      idle = {
        frames = {
          quad(2, 1926, 238, 166, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094),
          quad(2, 1172, 231, 375, 242, 2094),
          quad(2, 795, 231, 375, 242, 2094)
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
          quad(130, 121, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(130, 121, 62, 117, 242, 2094),
          quad(2, 121, 62, 117, 242, 2094),
          quad(66, 121, 62, 117, 242, 2094),
          quad(131, 2, 62, 117, 242, 2094),
          quad(2, 240, 62, 117, 242, 2094),
          quad(66, 240, 62, 117, 242, 2094),
          quad(130, 240, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      },
      dash = {
        frames = {
          quad(74, 641, 70, 152, 242, 2094),
          quad(146, 641, 70, 152, 242, 2094),
          quad(2, 641, 70, 152, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    animations = character
  },
  warrior = {
    atlas = image("assets/images/warrior.png"),
    unarmed = {
      idle = {
        frames = {
          quad(2, 2, 127, 76, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      },
      dash = {
        frames = {
          quad(123, 359, 117, 139, 242, 2094),
          quad(2, 500, 117, 139, 242, 2094),
          quad(121, 500, 117, 139, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    bow = {
      idle = {
        frames = {
          quad(2, 1926, 238, 166, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094),
          quad(2, 1172, 231, 375, 242, 2094),
          quad(2, 795, 231, 375, 242, 2094)
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
          quad(130, 121, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(130, 121, 62, 117, 242, 2094),
          quad(2, 121, 62, 117, 242, 2094),
          quad(66, 121, 62, 117, 242, 2094),
          quad(131, 2, 62, 117, 242, 2094),
          quad(2, 240, 62, 117, 242, 2094),
          quad(66, 240, 62, 117, 242, 2094),
          quad(130, 240, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      },
      dash = {
        frames = {
          quad(74, 641, 70, 152, 242, 2094),
          quad(146, 641, 70, 152, 242, 2094),
          quad(2, 641, 70, 152, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    animations = character
  },
  speedBuffer = {
    atlas = image("assets/images/speedBuffer.png"),
    unarmed = {
      idle = {
        frames = {
          quad(2, 2, 127, 76, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      },
      dash = {
        frames = {
          quad(123, 359, 117, 139, 242, 2094),
          quad(2, 500, 117, 139, 242, 2094),
          quad(121, 500, 117, 139, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    bow = {
      idle = {
        frames = {
          quad(2, 1926, 238, 166, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094),
          quad(2, 1172, 231, 375, 242, 2094),
          quad(2, 795, 231, 375, 242, 2094)
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
          quad(130, 121, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(130, 121, 62, 117, 242, 2094),
          quad(2, 121, 62, 117, 242, 2094),
          quad(66, 121, 62, 117, 242, 2094),
          quad(131, 2, 62, 117, 242, 2094),
          quad(2, 240, 62, 117, 242, 2094),
          quad(66, 240, 62, 117, 242, 2094),
          quad(130, 240, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      },
      dash = {
        frames = {
          quad(74, 641, 70, 152, 242, 2094),
          quad(146, 641, 70, 152, 242, 2094),
          quad(2, 641, 70, 152, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    animations = character
  },
   stunner = {
    atlas = image("assets/images/stunner.png"),
    unarmed = {
      idle = {
        frames = {
          quad(2, 2, 127, 76, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      },
      dash = {
        frames = {
          quad(123, 359, 117, 139, 242, 2094),
          quad(2, 500, 117, 139, 242, 2094),
          quad(121, 500, 117, 139, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    bow = {
      idle = {
        frames = {
          quad(2, 1926, 238, 166, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094),
          quad(2, 1172, 231, 375, 242, 2094),
          quad(2, 795, 231, 375, 242, 2094)
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
          quad(130, 121, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(130, 121, 62, 117, 242, 2094),
          quad(2, 121, 62, 117, 242, 2094),
          quad(66, 121, 62, 117, 242, 2094),
          quad(131, 2, 62, 117, 242, 2094),
          quad(2, 240, 62, 117, 242, 2094),
          quad(66, 240, 62, 117, 242, 2094),
          quad(130, 240, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      },
      dash = {
        frames = {
          quad(74, 641, 70, 152, 242, 2094),
          quad(146, 641, 70, 152, 242, 2094),
          quad(2, 641, 70, 152, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    animations = character
  },
  healer = {
    atlas = image("assets/images/healer.png"),
    unarmed = {
      idle = {
        frames = {
          quad(2, 2, 127, 76, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1},
        interval = 0.25
      },
      dash = {
        frames = {
          quad(123, 359, 117, 139, 242, 2094),
          quad(2, 500, 117, 139, 242, 2094),
          quad(121, 500, 117, 139, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    bow = {
      idle = {
        frames = {
          quad(2, 1926, 238, 166, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword_shield = {
      idle = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094)
        },
        anchorX = 0.49,
        anchorY = 0.36,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(2, 1549, 231, 375, 242, 2094),
          quad(2, 1172, 231, 375, 242, 2094),
          quad(2, 795, 231, 375, 242, 2094)
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
          quad(130, 121, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(130, 121, 62, 117, 242, 2094),
          quad(2, 121, 62, 117, 242, 2094),
          quad(66, 121, 62, 117, 242, 2094),
          quad(131, 2, 62, 117, 242, 2094),
          quad(2, 240, 62, 117, 242, 2094),
          quad(66, 240, 62, 117, 242, 2094),
          quad(130, 240, 62, 117, 242, 2094)
        },
        anchorX = 0.5,
        anchorY = 0.5,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      },
      dash = {
        frames = {
          quad(74, 641, 70, 152, 242, 2094),
          quad(146, 641, 70, 152, 242, 2094),
          quad(2, 641, 70, 152, 242, 2094)
        },
        anchorX = 0.50,
        anchorY = 0.46,
        sequence = {1, 2, 3},
        interval = 0.07
      }
    },
    animations = character
  },
  enemy = {
    atlas = image("assets/images/enemy.png"),
    bow = {
      idle = {
        frames = {
          quad(2, 237, 447, 289, 1012, 1611)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      }
    },
    sword = {
      idle = {
        frames = {
          quad(451, 237, 503, 685, 1012, 1611)
        },
        anchorX = 0.56,
        anchorY = 0.28,
        sequence = {1},
        interval = 0.25
      },
      stab = {
        frames = {
          quad(451, 237, 503, 685, 1012, 1611),
          quad(2, 924, 503, 685, 1012, 1611),
          quad(507, 924, 503, 685, 1012, 1611)
        },
        anchorX = 0.56,
        anchorY = 0.28,
        sequence = {1, 2, 2, 3, 3, 3, 3, 2, 1},
        interval = 0.05
      }
    },
    legs = {
      idle = {
        frames = {
          quad(466, 2, 114, 233, 1012, 1611)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1},
        interval = 0.25
      },
      walk = {
        frames = {
          quad(466, 2, 114, 233, 1012, 1611),
          quad(698, 2, 114, 233, 1012, 1611),
          quad(350, 2, 114, 233, 1012, 1611),
          quad(118, 2, 114, 233, 1012, 1611),
          quad(582, 2, 114, 233, 1012, 1611),
          quad(234, 2, 114, 233, 1012, 1611),
          quad(2, 2, 114, 233, 1012, 1611)
        },
        anchorX = 0.5,
        anchorY = 0.4,
        sequence = {1, 2, 4, 6, 6, 4, 2, 1, 3, 5, 7, 7, 5, 3},
        interval = 0.05
      }
    },
    animations = enemy
  },
  items = {
    atlas = image("assets/images/items.png"),
    regularSword = {
      frames = {
        quad(1, 1, 187, 200, 660, 208)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    regularBow = {
      frames = {
        quad(188, 1, 281, 200, 660, 208)
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
        quad(484, 1, 187, 200, 660, 208)
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
        quad(1, 1, 120, 115, 250, 200)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    minionAsset = {
      frames = {
        quad(126, 1, 74, 115, 250, 200)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    beamAsset = {
      frames = {
        quad(215, 1, 30, 200, 250, 200)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  },
  aura = {
    atlas = image("assets/images/aura.png"),
    healingaura = {
      frames = {
        quad(0, 0, 200, 200, 200, 200)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  },
  projectiles = {
    atlas = image("assets/images/projectiles.png"),
    arrow = {
      frames = {
        quad(1, 1, 20, 32, 40, 32)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    eyeball = {
      frames = {
        quad(20, 1, 20, 32, 40, 32)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  },
  lives = {
    atlas = image("assets/images/lives3.png"),
    five = {
      frames = {
        quad(1, 1, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    four = {
      frames = {
        quad(1, 57, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    three = {
      frames = {
        quad(1, 118, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    two = {
      frames = {
        quad(1, 178, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    one = {
      frames = {
        quad(1, 235, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    },
    zero = {
      frames = {
        quad(1, 295, 300, 56, 300, 356)
      },
      anchorX = 0.5,
      anchorY = 0.5
    }
  }
}

-- populate the newly created tables with animation references
character["unarmed-idle"] = assets.character.unarmed.idle
character["unarmed-dash"] = assets.character.unarmed.dash
character["bow-idle"] = assets.character.bow.idle
character["sword-shield-idle"] = assets.character.sword_shield.idle
character["sword-shield-stab"] = assets.character.sword_shield.stab
character["legs-idle"] = assets.character.legs.idle
character["legs-walk"] = assets.character.legs.walk
character["legs-dash"] = assets.character.legs.dash

enemy["bow-idle"] = assets.enemy.bow.idle
enemy["sword-idle"] = assets.enemy.sword.idle
enemy["sword-stab"] = assets.enemy.sword.stab
enemy["legs-idle"] = assets.enemy.legs.idle
enemy["legs-walk"] = assets.enemy.legs.walk

return assets
