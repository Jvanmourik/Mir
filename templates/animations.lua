-- get all possible graphics
local graphics = require "templates/graphics"

-- create tables to store all different animations
local kramer = {}

-- populate the newly created tables with animations
kramer["walk"] = {
  frames = graphics.kramer.walk.frames,
  interval = 0.25
}
kramer["moonwalk"] = {
  frames = graphics.kramer.moonwalk.frames,
  interval = 0.25
}

-- makes referencing a specific animation set easier
return {
  kramer = kramer
}
