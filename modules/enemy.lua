local Character = require "modules/character"

local function enemy(x, y)
  local self = Character(x, y)

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
      -- distance between self and target
      local distance = vector.length(self.x - target.x, self.y - target.y)

      if distance < 200 then
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
      end
    end
  end


  ----------------------------------------------
  return self
end

return enemy
