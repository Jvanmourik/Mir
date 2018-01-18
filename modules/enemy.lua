local Character = require "modules/character"

local function enemy(x, y)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "enemy"
  self.speed = 400


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- agent component to implement AI
  self:addComponent("agent")


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local target
  local players
  local timer = 0
  local aggroDistance = 200
  local attackCooldown = 1500
  local isAttacking = false

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- get players
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
        if d > 100 and not isAttacking then
          self.agent:goToPoint(target.x, target.y)
        elseif self.agent.state == "walk" then
          self.agent:stop()
        end

        -- look at target if agent is idle
        if not isAttacking and self.agent.state == "idle" then
          self.body:lookAt(target.x, target.y)
        end

        -- attack
        if d < 100 and timer <= 0 then
          isAttacking = true
          self:attack(function()
            isAttacking = false
          end)
          timer = attackCooldown
        end

        -- update timer
        timer = timer - 1000 * dt
      end
    end

    -- call base update method
    base.update(self, dt)
  end

  function self:moveToPoint(x, y, dt)
    local deltaX = x - self.x
    local deltaY = y - self.y
    local dirX, dirY = vector.normalize(deltaX, deltaY)

    -- apply input multiplied with speed to velocity
    self.x, self.y = self.x + dirX * self.speed * dt, self.y + dirY * self.speed * dt

    -- make node look at destination
    self.body:lookAt(self.x + dirX, self.y + dirY)
  end


  ----------------------------------------------
  return self
end

return enemy
