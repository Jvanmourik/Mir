local Node = require "modules/node"

local function health()
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------


  ----------------------------------------------
  -- components
  ----------------------------------------------
  local body = Node()

  -- sprite renderer component to render the sprite
  for i=1,health do
    body:addComponent("spriteRenderer",
    { atlas = heart,
    asset = heart,
    layer = 1 })
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
