local Node = require "modules/node"

local function character(x, y, gamepad)
  local self = Node(x, y)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 40
  self.height = 40
  self.anchorX = 0.5
  self.anchorY = 0.5

  self.speed = 400


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 20
  })



  ----------------------------------------------
  -- child nodes
  ----------------------------------------------

  local legs = Node()
  legs.scale = 0.5

  -- sprite renderer component to render the sprite
  legs:addComponent("spriteRenderer",
  { atlas = "images/character.png",
    asset = assets.character.legs.idle,
    layer = 0 })

  -- animator component to animate the sprite
  legs:addComponent("animator",
  { animations = assets.character.animations })
  legs.animator:play("legs-idle", 0)

  self:addChild(legs)


  ----------------------------------------------

  local body = Node()
  body.scale = 0.5

  -- sprite renderer component to render the sprite
  body:addComponent("spriteRenderer",
  { atlas = "images/character.png",
    asset = assets.character.sword_shield.idle,
    layer = 1 })

  -- animator component to animate the sprite
  body:addComponent("animator",
  { animations = assets.character.animations })
  body.animator:play("sword-shield-idle", 0)

  self:addChild(body)


  ----------------------------------------------

  local hitbox = Node(-10, 50, 25, 75)
  hitbox.anchorX, hitbox.anchorY = 0.5, 0

  hitbox:addComponent("collider")
  hitbox.collider.active = false

  body:addChild(hitbox)

  function hitbox:onCollisionEnter(dt, other, delta)
    if other.name == "enemy" then
      other:damage()
    end
  end

  function hitbox:endContact(f, contact)
    --print("endContact")
  end


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
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

      -- arrow keys
      if vector.length(dirX, dirY) > 0 then
        -- character movement
        self.x = self.x + self.speed * dt * dirX
        self.y = self.y + self.speed * dt * dirY

        -- rotate legs at walking direction
        legs.rotation = vector.angle(0, 1, dirX, dirY)

        -- animate legs
        if not legs.animator:isPlaying("legs-walk") then
          legs.animator:play("legs-walk", 0)
        end
      elseif not legs.animator:isPlaying("legs-idle") then
        legs.animator:play("legs-idle", 0)
      end

      -- make character look at direction
      body:lookAt(lm.getPosition())

      -- character attack
      if input:isPressed(1) and not body.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        hitbox.collider.active = true

        -- change animation
        body.animator:play("sword-shield-stab", 1, function()
          body.animator:play("sword-shield-idle", 0)
          hitbox.collider.active = false
        end)
      end

    end
  end

  function self:onCollision(dt, other, delta)
    if other.name == "unreachable" then
      self.x = self.x + delta.x
      self.y = self.y + delta.y
    end
  end


  ----------------------------------------------
  return self
end

return character
