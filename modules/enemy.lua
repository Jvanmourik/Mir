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

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if not self.target then
      self.target = scene.rootNode:getChildByName("player")
    end

    -- make enemy look at character in a certain range
    if self.target and vector.length(self.x - c.x, self.y - c.y) < 200  and c.active then
      if not self.body.animator:isPlaying("sword-shield-stab") then
        self:lookAt(c.x, c.y)
      end
      if self.timer <= 0 then
        -- enable hitbox
        self.hitbox.collider.active = true

        -- change animation
        if not self.body.animator:isPlaying("sword-shield-stab") then
          self.body.animator:play("sword-shield-stab", 1, function()
            self.body.animator:play("sword-shield-idle", 0)
            self.hitbox.collider.active = false
            self.timer = 60
          end)
        end
      end
    end
    self.timer = self.timer - 1
  end


  ----------------------------------------------
  return self
end

return enemy
