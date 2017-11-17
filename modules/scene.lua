local Node = require "modules/node"

local function scene(...)
  local self = Node(...)

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    for key, child in pairs(self:getAllChildren()) do
      if child.active then
        child:update(dt)
      end
    end
  end

  function self:draw()
    for key, child in pairs(self:getAllChildren()) do
      if child.graphic then
        child.graphic:draw(child:getWX(), child:getWY())
      end
    end
  end


  ----------------------------------------------
  return self
end

return scene
