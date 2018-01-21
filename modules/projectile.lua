local Node = require "modules/node"

local function projectile(x, y, dirX, dirY, damage, id)
  local self = Node(x, y)

    local assets = require "templates/assets"
  ----------------------------------------------
  -- attributes
  ----------------------------------------------
  angle = vector.angle(0, -1, dirX, dirY)
  self.rotation = angle
  local timer = 600
  ----------------------------------------------
  -- components
  ----------------------------------------------
  self:addComponent("spriteRenderer", {
    atlas = assets.items.atlas,
    asset = assets.items.arrow,
    layer = 0
  })

  self:addComponent("collider", {
    shapeType = "rectangle",
    width = 15,
    height = 44,
    sensor = true
  })
  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- handle collision
  function self:onCollisionEnter(dt, other, delta)
    if other.damage and type(other.damage) == "function" then
      other:damage(damage)
      timer = 2
    end
  end

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    self.x = self.x + dirX * dt * 1000
    self.y = self.y + dirY * dt * 1000
    timer = timer - 1
    if timer <= 0 then
      self.active = false
    end
  end
  ----------------------------------------------
  return self
end

return projectile
