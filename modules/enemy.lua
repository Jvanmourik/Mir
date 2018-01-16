local Character = require "modules/character"

local function enemy(x, y)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "enemy"
  self.timer = 0


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

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if not target then
      target = scene.rootNode:getChildByName("player")
    end

    if target then

      local distance = vector.length(target.x - self.x, target.y - self.y)

      if distance < 200 then
        self.agent:goToPoint(target.x, target.y)
      end
      --[[-- distance between self and target
      local distance = vector.length(target.x - self.x, target.y - self.y)

      if distance < 200 then
        local dirX, dirY = vector.normalize(target.x - self.x, target.y - self.y)
        -- apply input multiplied with speed to velocity
        self.velocityX, self.velocityY = dirX * self.speed, dirY * self.speed

        -- make enemy look at target in a certain range
        if not self.body.animator:isPlaying("sword-shield-stab") then
          self:lookAt(target.x, target.y)
        end

        -- attack
        if timer <= 0 then
          -- enable hitbox
          self.hitbox.collider.active = true

          -- change animation
          if not self.body.animator:isPlaying("sword-shield-stab") then
            self.body.animator:play("sword-shield-stab", 1, function()
              self.body.animator:play("sword-shield-idle", 0)
              self.hitbox.collider.active = false
              timer = 1000
            end)
          end
        end

        -- update timer
        timer = timer - 1000 * dt
      end]]
    end

    -- call base update method
    base.update(self, dt)
  end


  ----------------------------------------------
  return self
end

return enemy
