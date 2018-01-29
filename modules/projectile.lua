local Node = require "modules/node"

local function projectile(x, y, dirX, dirY, damage, id)
  local self = Node(x, y)

    local assets = require "templates/assets"
  ----------------------------------------------
  -- attributes
  ----------------------------------------------
  angle = vector.angle(0, -1, dirX, dirY)
  self.rotation = angle
  local timer = 120
  id = id or "arrow"
  ----------------------------------------------
  -- components
  ----------------------------------------------
  if id == "arrow" then
    self:addComponent("spriteRenderer", {
      atlas = assets.projectiles.atlas,
      asset = assets.projectiles.arrow,
      layer = 0
    })
    self:addComponent("collider", {
      shapeType = "rectangle",
      width = 15,
      height = 44,
      sensor = true
    })
  elseif id == "eyeball" then
    self:addComponent("spriteRenderer", {
      atlas = assets.projectiles.atlas,
      asset = assets.projectiles.eyeball,
      layer = 0
    })
    self:addComponent("collider", {
      shapeType = "circle",
      radius = 10,
      sensor = true
    })
  end

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- handle collision
  function self:onCollisionEnter(dt, other, delta)
    if id == "arrow" then
      if other.damage and type(other.damage) == "function" then
        other:damage(damage)
        timer = 2
      end
    elseif id == "eyeball" then
      boss = scene.rootNode:getChildByName("boss")
      bossMinions = scene.rootNode:getChildrenByName("bossMinion")
      if other.damage and type(other.damage) == "function" and other ~= boss then
        for i=1, #bossMinions do
          if bossMinions[i] == other then
            return
          end
        end
        other:damage(damage/4)
        timer = 2
      end
    end
  end

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if id == "arrow" then
      self.x = self.x + dirX * dt * 1000
      self.y = self.y + dirY * dt * 1000
    elseif id == "eyeball" then
      self.x = self.x + dirX * dt * 200
      self.y = self.y + dirY * dt * 200
    end
    timer = timer - 1
    if timer <= 0 then
      self.active = false
    end
  end

  ----------------------------------------------
  return self
end

return projectile
