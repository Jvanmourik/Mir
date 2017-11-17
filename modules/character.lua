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
    -- translate self.x by 100 pixels/second
    self.x = self.x + 100 * dt
  end


  ----------------------------------------------
  return self
end

return character
