local Node = require "modules/node"
local items = require "templates/items"
local assets = require "templates/assets"
--local Character = require "modules/character"

local function boss(x,y)
  local self = Node(x, y)
  ---attributes
  self.damage = 40

  self:addComponent("collider", {
    shapeType = "circle",
    radius = 50
  })

  self:addComponent("agent")

  function self:onCollisionEnter(dt, other, delta)
    if other.damage and type(other.damage) == "function" then
      other:damage(self.damage)
    end
  end
  --spriteRenderer (temp)
  --[[self.body = Node()
  self.body.scale = 0.5]]

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { atlas = assets.boss.atlas,
    asset = assets.boss.bossAsset,
    layer = 0 })

  -- animator component to animate the sprite
  --[[self.body:addComponent("animator",
  { animations = assets.character.animations })
  self.body.animator:play("sword-shield-idle", 0)

  self:addChild(self.body)]]

  --collision
  --[[self.hitbox = Node(-20, 80, 25, 75)
  self.hitbox.anchorX, self.hitbox.anchorY = 0.5, 0

  -- collider component to collide with other collision objects
  self.hitbox:addComponent("collider")
  self.hitbox.collider.active = false
  self.hitbox.collider.isSensor = true/]]

  local aggroDistance = 300
  --update
  function self:update(dt)
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
        -- move to target
        --if d > 100 and not isAttacking then
          --self.agent:goToPoint(target.x, target.y)
        --[[elseif self.agent.state == "walk" then
          self.agent:stop()
        end]]

        -- look at target if agent is idle
        --if not isAttacking and self.agent.state == "idle" then
          --self.body:lookAt(target.x, target.y)
        --end

        -- attack
        --[[if d < 100 and timer <= 0 then
          isAttacking = true
          self:attack(function()
            isAttacking = false
          end)
          timer = attackCooldown
        end
      end]]

      -- update timer
      --timer = timer - 1000 * dt
      end
    end
  end
  return self
end

return boss
