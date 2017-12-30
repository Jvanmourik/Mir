local Node = require "modules/node"

local function layer(...)
  local self = Node(...)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if self.scale ~= 1 then
      self.x = (camera.x/self.width) * (self.width - self.width * self.scale)
      self.y = (camera.y/self.height) * (self.height - self.height * self.scale)
    end
  end

  ----------------------------------------------
  return self
end

return layer
