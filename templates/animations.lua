-- get all possible graphics
local graphics = require "templates/graphics"

-- create tables to store all different animations
local kramer = {}
local redenemysprite = {}

-- populate the newly created tables with animations
kramer["walk"] = {
  frames = graphics.kramer.walk.frames,
  interval = 0.25
}
kramer["moonwalk"] = {
  frames = graphics.kramer.moonwalk.frames,
  interval = 0.25
}
redenemysprite["shrink"] = {
  frames = graphics.redenemysprite.shrink.frames,
  interval = 0.25
}
-- makes referencing a specific animation set easier
return {
  redenemysprite = redenemysprite,
  kramer = kramer
}
