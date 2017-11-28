-- get all possible assets
local graphics = require "templates/graphics"
local animations = require "templates/animations"

-- makes referencing a specific asset easier
return {
  redenemysprite = {
    graphics = graphics.redenemysprite,
    animations = animations.redenemysprite
  },
  kramer = {
    graphics = graphics.kramer,
    animations = animations.kramer
  }
}
