local Node = require "modules/node"

local function layer(...)
  local self = Node(...)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.visible = true

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if self.scale ~= 1 then
      local x = (camera.x/self.width) * (self.width - self.width * self.scale)
      local y = (camera.y/self.height) * (self.height - self.height * self.scale)
      self.x = math.floor(x + 0.5)
      self.y = math.floor(y + 0.5)
      print(self.x, self.y)
    end
  end

  function self:draw()
    if self.tilesetBatch then
    lg.draw(self.tilesetBatch, self.x, self.y, r, self.scale, self.scale)
  end
  end

  ----------------------------------------------
  return self
end

return layer
