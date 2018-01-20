local Node = require "modules/node"

local function particleSystem(image, buffer, ...)
  local self = Node(...)

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.system = lg.newParticleSystem(image, buffer)
  self.visible = true


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    self.system:update(dt)
  end

  function self:draw()
    -- position
    local x, y = self:getWorldCoords()

    -- rotation
    local r = self:getWorldRotation()

    -- draw particleSystem
    lg.draw(self.system, x, y, r)
  end

  ----------------------------------------------
  return self
end

return particleSystem
