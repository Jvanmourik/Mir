local Character = require "modules/character"

local function character(x, y, gamepad)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "player"


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- call base update method
    base.update(self, dt)

    if gamepad then -- gamepad

      -- input
      local leftX = gamepad:getAxis('leftx')
      local leftY = gamepad:getAxis('lefty')
      local rightX = gamepad:getAxis('rightx')
      local rightY = gamepad:getAxis('righty')

      -- left analog stick
      if vector.length(leftX, leftY) > 0.3 then
        local dirX, dirY = vector.normalize(leftX, leftY)

        -- character movement
        self.x = self.x + self.speed * dt * leftX
        self.y = self.y + self.speed * dt * leftY

        -- rotate legs at walking direction
        legs.rotation = vector.angle(0, 1, dirX, dirY)

        -- animated legs
        if not legs.animator:isPlaying("legs-walk") then
          legs.animator:play("legs-walk", 0)
        end
      elseif not legs.animator:isPlaying("legs-idle") then
        legs.animator:play("legs-idle", 0)
      end

      -- right analog stick
      if vector.length(rightX, rightY) > 0.3 then
        local dirX, dirY = vector.normalize(rightX, rightY)

        -- make character look at direction
        body.rotation = vector.angle(0, 1, dirX, dirY)
      end

      -- character attack
      if gamepad:isPressed('rightshoulder') and not body.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        hitbox.collider.active = true

        -- change animation
        body.animator:play("sword-shield-stab", 1, function()
          body.animator:play("sword-shield-idle", 0)
          hitbox.collider.active = false
        end)
      end

    else -- keyboard and mouse

      -- input
      local dirX, dirY = 0, 0
      if input:isDown('a') or input:isDown('left') then dirX = -1 end
      if input:isDown('d') or input:isDown('right') then dirX = 1 end
      if input:isDown('w') or input:isDown('up') then dirY = -1 end
      if input:isDown('s') or input:isDown('down') then dirY = 1 end

      -- normalize input
      dirX, dirY = vector.normalize(dirX, dirY)

      -- apply input multiplied with speed to velocity
      if vector.length(self.velocityX, self.velocityY) <= self.speed then
        self.velocityX, self.velocityY = dirX * self.speed, dirY * self.speed

        if vector.length(dirX, dirY) > 0 then
          -- character movement
          if input:isPressed("space") then
            self.velocityX, self.velocityY = dirX * self.rollSpeed, dirY * self.rollSpeed
          end

        end
      end

      -- add velocity to position
      self.x = self.x + self.velocityX * dt
      self.y = self.y + self.velocityY * dt

      -- apply drag to velocity
      self.velocityX = self.velocityX * (1 - self.dragX * dt)
      self.velocityY = self.velocityY * (1 - self.dragY * dt)

      -- make character look at direction
      local x,y = lm.getPosition()
      local cx,cy = camera:mousePosition()
      self.body:lookAt(camera:mousePosition())

      -- character attack
      if input:isPressed(1) and not self.body.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        self.hitbox.collider.active = true

        -- change animation
        self.body.animator:play("sword-shield-stab", 1, function()
          self.body.animator:play("sword-shield-idle", 0)
          self.hitbox.collider.active = false
        end)
      end


    end
  end


  ----------------------------------------------
  return self
end

return character
