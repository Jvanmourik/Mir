local Node = require "modules/node"

local function chooseclassgui(x, y, w, h, r, s, ax, ay, l)
  local self = Node(x, y, w, h, r, s, ax, ay, l)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------



  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  --[[self:addComponent("spriteRenderer",
  { atlas = assets.lives.atlas,
    asset = assets.lives.five,
    layer = 1000 })

  self.scale = 0.5]]

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)

  end

  ----------------------------------------------
  return self
end

return chooseclassgui
