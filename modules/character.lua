local Node = require "modules/node"
local Graphic = require "modules/graphic"

local function character(...)
  local self = Node(...)

  ----------------------------------------------
  -- components
  ----------------------------------------------

  self.graphic = Graphic(16, 14)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.health = 31


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
