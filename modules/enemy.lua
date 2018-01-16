local Character = require "modules/character"

local function enemy(x, y)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "enemy"
  self.speed = 200


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- agent component to implement AI
  self:addComponent("agent")


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local target
  local timer = 0
  local isAttacking = false

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- get target
    if not target then
      target = scene.rootNode:getChildByName("player")
    end

    if target then
      local distance = vector.length(target.x - self.x, target.y - self.y)

      -- if in range
      if distance < 400 then
        -- move to target
        if not isAttacking then
          self.agent:goToPoint(target.x, target.y, _, 90)
        elseif self.agent.state == "walk" then
          self.agent:stop()
        end

        if not isAttacking and self.agent.state == "idle" then
          self.body:lookAt(target.x, target.y)
        end

        -- attack
        if distance < 100 and timer <= 0 then
          isAttacking = true
          self:attack(function()
            isAttacking = false

          end)
          timer = 1500
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
