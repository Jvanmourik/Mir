local Node = require "modules/node"
local Graphic = require "modules/graphic"

local function character(x, y, w, h, r, ax, ay, l)
  local self = Node(x, y, w, h, r, ax, ay)
  local quads = require "templates/graphics"

  local quad = quads.pikachu
  local sw, sh = quad:getTextureDimensions()


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- graphic component to render the sprite
  local atlas = lg.newImage("assets/images/atlas.png")
  self.graphic = Graphic(self, atlas, quad, l)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or sw
  self.height = h or sh


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end


  ----------------------------------------------
  return self
end

return character
