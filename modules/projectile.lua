local Node = require "modules/node"

local function projectile(x, y, dirX, dirY, damage, id)
  local self = Node(x, y)

    local assets = require "templates/assets"
  ----------------------------------------------
  -- attributes
  ----------------------------------------------
  self.dirX, self.dirY = dirX, dirY
  self.timer = 3000
  id = id or "arrow"
  local stunTimer = 120
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
  elseif id == "stunprojectile" then
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
        self.timer = 50
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
        self.timer = 50
      end
    elseif id == "stunprojectile"then
      if other.stun and type(other.stun) == "function" then
        other:stun(stunTimer)
        self.timer = 0
      end
    end
  end

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if id == "arrow" then
      self.rotation = vector.angle(0, -1, self.dirX, self.dirY)
      self.x = self.x + self.dirX * dt * 1000
      self.y = self.y + self.dirY * dt * 1000
    elseif id == "eyeball" then
      self.x = self.x + self.dirX * dt * 200
      self.y = self.y + self.dirY * dt * 200
    elseif id == "stunprojectile" then
      self.rotation = vector.angle(0, -1, self.dirX, self.dirY)
      self.x = self.x + self.dirX * dt * 400
      self.y = self.y + self.dirY * dt * 400
    end
    self.timer = self.timer - 1000 * dt
    if self.timer <= 0 then
      self.active = false
    end
    --[[if self.dirX == 0 and self.dirY == 0 then
      self.active = false
    end]]
  end
  ----------------------------------------------
  return self
end

return projectile
