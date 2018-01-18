local assets = require "templates/assets"

-- Stores all items
local items = {
  atlas = assets.items.atlas,
  {
    id = 1,
    name = "regularSword",
    damage = 5,
    type = "sword",
    asset = assets.items.regularSword
  },
  {
    id = 2,
    name = "regularBow",
    damage = 2,
    type = "bow",
    asset = assets.items.regularBow
  },
  {
    id = 3,
    name = "regularDamageStaff",
    damage = 4,
    type = "damageStaff",
    asset = assets.items.regularDamageStaff
  },
  {
    id = 4,
    name = "regularHealingStaff",
    damage = 4,
    type = "healingStaff",
    asset = assets.items.regularHealingStaff
  },
  {
    id = 5,
    name = "bloodSword",
    damage = 10,
    type = "sword",
    asset = assets.items.bloodSword
  }
}

return items
