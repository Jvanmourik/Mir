-- get all possible graphics
local graphics = require "templates/graphics"

-- stores all possible animations
local animations = {}

-- populate the newly created table with animations
animations.kramer = {}
animations.kramer["walk"] = {
  frames = graphics.kramer.walk.frames,
  interval = 0.25
}

return animations
