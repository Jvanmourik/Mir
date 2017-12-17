local Node = require "modules/node"

local function character(x, y, gamepad)
  local self = Node(x, y)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 40
  self.height = 50
  self.anchorX = 0.5
  self.anchorY = 0.5

  self.speed = 400


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  self:addComponent("collider")


  ----------------------------------------------
  -- child nodes
  ----------------------------------------------

  local graphic = Node()

  graphic.scaleX = 0.5
  graphic.scaleY = 0.5

  -- sprite renderer component to render the sprite
  graphic:addComponent("spriteRenderer",
  { atlas = "character.png",
    sprite = assets.character.sword_shield.idle,
    layer = layer })

  -- animator component to animate the sprite
  graphic:addComponent("animator",
  { animations = assets.character.animations })
  graphic.animator:play("sword-shield-idle", 0)

  self:addChild(graphic)


  ----------------------------------------------

  local hitbox = Node(-10, 50, 25, 75, math.pi * 0)

  hitbox.anchorX, hitbox.anchorY = 0.5, 0
  hitbox:addComponent("collider")
  hitbox.collider.body:setActive(false)

  self:addChild(hitbox)

  function hitbox:beginContact(f, contact)
    local collider = f:getUserData()
    if collider.name == "enemy" then
      collider:damage()
    end
  end

  function hitbox:endContact(f, contact)
    --print("endContact")
  end


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if gamepad then
      local leftX = gamepad:getAxis('leftx')
      local leftY = gamepad:getAxis('lefty')
      local rightX = gamepad:getAxis('rightx')
      local rightY = gamepad:getAxis('righty')

      -- character movement
      if vector.length(leftX, leftY) > 0.3 then
        local dirX, dirY = vector.normalize(leftX, leftY)
        self.x = self.x + self.speed * dt * leftX
        self.y = self.y + self.speed * dt * leftY
      end

      -- make character look at direction
      if vector.length(rightX, rightY) > 0.3 then
        local dirX, dirY = vector.normalize(rightX, rightY)
        self.rotation = vector.angle(0, 1, dirX, dirY)
      end

      -- character attack
      if gamepad:isPressed('rightshoulder') and not graphic.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        hitbox.collider.body:setActive(true)

        -- change animation
        graphic.animator:play("sword-shield-stab", 1, function()
          graphic.animator:play("sword-shield-idle", 0)
          hitbox.collider.body:setActive(false)
        end)
      end
    else
      -- character movement
      if input:isDown('a') then
        self.x = self.x - self.speed * dt
      end
      if input:isDown('d') then
        self.x = self.x + self.speed * dt
      end
      if input:isDown('w') then
        self.y = self.y - self.speed * dt
      end
      if input:isDown('s') then
        self.y = self.y + self.speed * dt
      end

      -- make character look at direction
      self:lookAt(lm.getPosition())

      -- character attack
      if input:isPressed(1) and not graphic.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        hitbox.collider.body:setActive(true)

        -- change animation
        graphic.animator:play("sword-shield-stab", 1, function()
          graphic.animator:play("sword-shield-idle", 0)
          hitbox.collider.body:setActive(false)
        end)
      end
    end
  end


  ----------------------------------------------
  return self
end

return character
