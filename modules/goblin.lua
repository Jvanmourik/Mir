local Node = require "modules/node"
local Item = require "modules/item"
local ParticleSystem = require "modules/particleSystem"

local function goblin(x, y, w, h, r, s, ax, ay, l)
  local self = Node(x, y, w, h, r, s, ax, ay, l)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "goblin"
  self.width, self.height = 40, 40
  self.anchorX, self.anchorY = 0.5, 0.5


  self.velocityX, self.velocityY = 0, 0
  self.dragX, self.dragY = 3, 3
  self.walkSpeed = 200
  self.speed = 400
  self.rollSpeed = 1200
  self.health = 1
  self.maxhealth = 1
  self.isDashing = false


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

  -- create legs
  self.legs = Node()
  self.legs.scale = 0.25

  -- sprite renderer component to render the sprite
  self.legs:addComponent("spriteRenderer",
  { atlas = assets.enemy.atlas,
    asset = assets.enemy.legs.idle,
    layer = 0 })

  -- animator component to animate the sprite
  self.legs:addComponent("animator",
  { animations = assets.enemy.animations })
  self.legs.animator:play("legs-idle", 0)

  self:addChild(self.legs)


  ----------------------------------------------

  -- create body
  self.body = Node()
  self.body.scale = 0.25

  -- sprite renderer component to render the sprite
  self.body:addComponent("spriteRenderer",
  { atlas = assets.enemy.atlas,
    asset = assets.enemy.sword.idle,
    layer = 1 })

  -- animator component to animate the sprite
  self.body:addComponent("animator",
  { animations = assets.enemy.animations })
  self.body.animator:play("sword-idle", 0)

  self:addChild(self.body)


  ----------------------------------------------

  -- create weapon
  self.weapon = Node(160, 160, 15, 75, 0.5)
  self.weapon.anchorX, self.weapon.anchorY = 0.5, 0

  -- add weapon template
  self.weapon.id = 1
  self.weapon.name = "regularSword"
  self.weapon.damage = 5
  self.weapon.type = "sword"

  -- collider component to collide with other collision objects
  self.weapon:addComponent("collider")
  self.weapon.collider.active = false
  self.weapon.collider.isSensor = true

  -- handle collision
  function self.weapon:onCollisionEnter(dt, other, delta)
    if other.damage and type(other.damage) == "function" then
      other:damage(self.damage)
    end
  end

  self.body:addChild(self.weapon)

  self.healthBar = Node(-40, -70, 80, 10)
  self.healthBar.anchorX, self.healthBar.anchorY = 0.5, 0.5
  self.healthBar.visible = true
  function self.healthBar:draw()
    local x, y = self:getWorldCoords()
    lg.setColor(255, 0 ,0)
    lg.rectangle("fill", x, y, self.width, self.height)
    lg.setColor(0, 255, 0)
    local barWidth = (self.parent.health/self.parent.maxhealth) * self.width
    lg.rectangle("fill", x, y, barWidth, self.height)
    lg.setColor(255, 255, 255)
  end
  self:addChild(self.healthBar)

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local prevX, prevY = self.x, self.y

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- add velocity to position
    self.x = self.x + self.velocityX * dt
    self.y = self.y + self.velocityY * dt

    -- apply drag to velocity
    self.velocityX = self.velocityX * (1 - self.dragX * dt)
    self.velocityY = self.velocityY * (1 - self.dragY * dt)

    --animate legs
    local deltaX, deltaY = self.x - prevX, self.y - prevY
    if (deltaX ~= 0 or deltaY ~= 0) then
      -- walk animation
      if not self.legs.animator:isPlaying("legs-walk") then
        self.legs.animator:play("legs-walk", 0)
      end

      -- rotate legs at walking direction
      self.legs.rotation = vector.angle(0, 1, deltaX, deltaY)

    elseif not self.legs.animator:isPlaying("legs-idle") then
      -- idle animation
      self.legs.animator:play("legs-idle", 0)
    end

    -- set previous x, y
    prevX, prevY = self.x, self.y
  end

  function self:attack(callback)
    if not self.body.animator:isPlaying("sword-stab") then
      -- enable weapon
      self.weapon.collider:setActive(true)

      -- change animation
      self.body.animator:play("sword-stab", 1, function()
        self.body.animator:play("sword-idle", 0)
        -- disable weapon
        self.weapon.collider:setActive(false)

        -- invoke callback
        if callback then callback() end
      end)
    end
  end

  -- apply damage to character
  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health > 0 then
      efMusic["hurt-0"..math.random(1,3)]:play()
    else
      self:kill()
    end
  end

  -- TODO: create inherit system for boolean 'active', so we don't need
  --       dedicated kill and revive methods for activationg and deactivation

  -- kill character
  function self:kill()
    efMusic["hitdie"..math.random(1,4)]:play()
    self.weapon.active = false
    self.healthBar.active = false
    self.body.active = false
    self.legs.active = false
    self.active = false
  end

  -- revive character
  function self:revive()
    self.weapon.active = true
    self.healthBar.active = true
    self.body.active = true
    self.legs.active = true
    self.active = true
    self.health = self.maxhealth
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

return goblin
