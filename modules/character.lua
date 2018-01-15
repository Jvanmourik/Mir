local Node = require "modules/node"

local function character(x, y, w, h, r, s, ax, ay, l)
  local self = Node(x, y, w, h, r, s, ax, ay, l)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 40
  self.height = 40
  self.anchorX = 0.5
  self.anchorY = 0.5

  self.velocityX = 0
  self.velocityY = 0
  self.dragX = 3
  self.dragY = 3
  self.speed = 400
  self.health = 1


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

  self.legs = Node()
  self.legs.scale = 0.5

  -- sprite renderer component to render the sprite
  self.legs:addComponent("spriteRenderer",
  { atlas = assets.character.atlas,
    asset = assets.character.legs.idle,
    layer = 0 })

  -- animator component to animate the sprite
  self.legs:addComponent("animator",
  { animations = assets.character.animations })
  self.legs.animator:play("legs-idle", 0)

  self:addChild(self.legs)


  ----------------------------------------------

  self.body = Node()
  self.body.scale = 0.5

  -- sprite renderer component to render the sprite
  self.body:addComponent("spriteRenderer",
  { atlas = assets.character.atlas,
    asset = assets.character.sword_shield.idle,
    layer = 1 })

  -- animator component to animate the sprite
  self.body:addComponent("animator",
  { animations = assets.character.animations })
  self.body.animator:play("sword-shield-idle", 0)

  self:addChild(self.body)


  ----------------------------------------------

  self.hitbox = Node(-20, 80, 25, 75)
  self.hitbox.anchorX, self.hitbox.anchorY = 0.5, 0

  -- collider component to collide with other collision objects
  self.hitbox:addComponent("collider")
  self.hitbox.collider.active = false
  self.hitbox.collider.isSensor = true

  -- handle collision
  function self.hitbox:onCollisionEnter(dt, other, delta)
    if other.damage then
      other:damage()
    end
  end

  self.body:addChild(self.hitbox)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- animate legs
    if vector.length(self.velocityX, self.velocityY) > 0 then
      if not self.legs.animator:isPlaying("legs-walk") then
        self.legs.animator:play("legs-walk", 0)
      end
    elseif not self.legs.animator:isPlaying("legs-idle") then
      self.legs.animator:play("legs-idle", 0)
    end

    -- rotate legs at walking direction
    self.legs.rotation = vector.angle(0, 1, self.velocityX, self.velocityY)
  end

  -- apply damage to character
  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  -- TODO: create inherit system for boolean 'active', so we don't need
  --       dedicated kill and revive methods for activationg and deactivation

  -- kill character
  function self:kill()
    self.hitbox.active = false
    self.body.active = false
    self.legs.active = false
    self.active = false
  end

  -- revive character
  function self:revive()
    self.hitbox.active = true
    self.body.active = true
    self.legs.active = true
    self.active = true
  end

  -- handle collision
  function self:onCollision(dt, other, delta)
    if not other.collider.isSensor then
      self.velocityX, self.velocityY = 0, 0

      -- adjust character position
      self.x = self.x + delta.x
      self.y = self.y + delta.y

      -- adjust collision shape position
      local cx, cy = self.collider.shape:center()
      self.collider.shape:moveTo(cx + delta.x, cy + delta.y)
    end
  end


  ----------------------------------------------
  return self
end

return character
