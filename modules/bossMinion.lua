--local Character = require "modules/character"
local assets = require "templates/assets"
local Node = require "modules/node"

local function bossMinion(x, y)
  local self = Node(x, y)
  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "bossMinion"
  self.speed = 150
  self.health = 1
  local damage = 40
  local timer = 30
  local aggroDistance = 500
  self.explosion = Node(0, 0, 10, 10)
  self.explosion.anchorX, self.explosion.anchorY = 0.5, 0.5
  self:addChild(self.explosion)
  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- agent component to implement AI
  self:addComponent("spriteRenderer",
  { atlas = assets.boss.atlas,
    asset = assets.boss.minionAsset,
    layer = 0 })

  --self:addComponent("agent")

  self:addComponent("collider", {
    shapeType = "circle",
    radius = 20
  })
  -- handle collision
  function self:onCollisionEnter(dt, other, delta)
    boss = scene.rootNode:getChildByName("boss")
    bossMinions = scene.rootNode:getChildrenByName("bossMinion")
    if other.damage and type(other.damage) == "function" and other ~= boss and timer <= 0 then
      --other:damage(damage)
      for i=1, #bossMinions do
        if bossMinions[i] == other then
          return
        end
      end
      self.explosion:addComponent("collider", {
        shapeType = "circle",
        radius = 100,
        sensor = true
      })
    end
  end

  function self.explosion:onCollisionEnter(dt, other, delta)
    boss = scene.rootNode:getChildByName("boss")
    if other.damage and type(other.damage) == "function" and other ~= boss then
      other:damage(damage)
      self.collider.active = false
    end
  end

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if timer > 0 then
      timer = timer - 1
    end
    if not players then
      players = scene.rootNode:getChildrenByName("player")
    end

    -- set closest player as target
    local distance
    for _, player in pairs(players) do
      if player.active then
        local d = vector.length(player.x - self.x, player.y - self.y)
        if not distance or d < distance then
          distance = d
          target = player
        end
      end
    end

    if target and target.active then
      local d = vector.length(target.x - self.x, target.y - self.y)

      -- if target in range
      if d < aggroDistance then
        local deltaX = target.x - self.x
        local deltaY = target.y - self.y
        local dirX, dirY = vector.normalize(deltaX, deltaY)
        self.x, self.y = self.x + dirX * self.speed * dt, self.y + dirY * self.speed * dt
        self:lookAt(target.x, target.y)
      end
  end

  function self:damage(amount)
    local amount = amount or 1
      self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  -- TODO: create inherit system for boolean 'active', so we don't need
  --       dedicated kill and revive methods for activationg and deactivation

  -- kill character
  function self:kill()
    self.active = false
  end

end

  return self
end

return bossMinion
