local Character = require "modules/character"

local function character(x, y, gamepad)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "player"
  self.rollSpeed = 800


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- call base update method
    base.update(self, dt)

    -- direction vector
    local dirX, dirY = 0, 0

    if gamepad then
      -- gamepad input
      local leftX = gamepad:getAxis('leftx')
      local leftY = gamepad:getAxis('lefty')
      local rightX = gamepad:getAxis('rightx')
      local rightY = gamepad:getAxis('righty')

      -- normalize input
      if vector.length(leftX, leftY) > 0.3 then
        dirX, dirY = vector.normalize(leftX, leftY)
      end

      -- make character look at direction
      if vector.length(rightX, rightY) > 0.3 then
        self.body.rotation = vector.angle(0, 1, vector.normalize(rightX, rightY))
      end
    else
      -- keyboard input
      if input:isDown('a') or input:isDown('left') then dirX = -1 end
      if input:isDown('d') or input:isDown('right') then dirX = 1 end
      if input:isDown('w') or input:isDown('up') then dirY = -1 end
      if input:isDown('s') or input:isDown('down') then dirY = 1 end

      -- normalize input
      dirX, dirY = vector.normalize(dirX, dirY)

      -- make character look at direction
      self.body:lookAt(camera:mousePosition())
    end

    -- is character speed below or equal to max speed?
    if vector.length(self.velocityX, self.velocityY) <= self.speed then
      -- apply input multiplied with speed to velocity
      self.velocityX, self.velocityY = dirX * self.speed, dirY * self.speed

      -- character roll
      if vector.length(dirX, dirY) > 0.3 then
        if input:isPressed("space") or gamepad and gamepad:isPressed('b') then
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


    -- character attack
    if not gamepad and input:isPressed(1) or gamepad and gamepad:isPressed('rightshoulder') then
      if not self.body.animator:isPlaying("sword-shield-stab") then
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
