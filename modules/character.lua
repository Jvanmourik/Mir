local Node = require "modules/node"
local Graphic = require "modules/graphic"

local function character(...)
  local self = Node(...)

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- graphic component to render the sprite
  local atlas = lg.newImage("assets/images/heart.png") -- TODO: this atlas needs to come from a template file
  local sw, sh = 16, 14 --[[TODO: this sprite width and height needs to come from a template file]]
  self.graphic = Graphic(self, atlas, sw, sh)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  --self.width = w or 16
  --self.height = h or 14


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- rotate clockwise at 1/4 rounds per second
    self.rotation = self.rotation + 0.5 * math.pi * dt
  end


  ----------------------------------------------
  return self
end

return character
