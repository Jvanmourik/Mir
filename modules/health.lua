local Node = require "modules/node"
local assets = require "templates/assets"

local function health(x, y, target)
  local self = Node(x, y, target)

  ----------------------------------------------
  -- attributes
  ----------------------------------------------


  ----------------------------------------------
  -- components
  ----------------------------------------------
  local body = Node()

  -- sprite renderer component to render the sprite
  for i=1,5 do
    self:addComponent("spriteRenderer",
    { atlas = assets.heart.atlas,
      asset = assets.heart.heartAsset,
      layer = 0 })
  end

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end


  ----------------------------------------------
  return self
end

return health
