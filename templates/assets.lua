-- get all possible assets
local graphics = require "templates/graphics"
local animations = require "templates/animations"

-- makes referencing a specific asset easier
return {
  character = {
    graphics = graphics.character,
    animations = animations.character
  },
  kramer = {
    graphics = graphics.kramer,
    animations = animations.kramer
  }
}
