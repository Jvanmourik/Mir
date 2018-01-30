local Node = require "modules/node"
local Item = require "modules/item"
local ParticleSystem = require "modules/particleSystem"

local function character(x, y, w, h, r, s, ax, ay, l)
  local self = Node(x, y, w, h, r, s, ax, ay, l)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
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

  -- create body
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

  local img = lg.newImage('assets/images/particle.png')

	self.ps = ParticleSystem(img, 32)
	self.ps.system:setParticleLifetime(0.3, 0.5) -- Particles live at least 2s and at most 5s.
	self.ps.system:setEmissionRate(15)
	self.ps.system:setSizeVariation(1)
	self.ps.system:setLinearAcceleration(0, -600, 0, -1000) -- Random movement in all directions.
	self.ps.system:setColors(255, 255, 255, 255, 255, 255, 255, 0) -- Fade to transparency.
  self.ps.visible = false

  self.legs:addChild(self.ps)


  ----------------------------------------------

  -- create weapon
  self.weapon = Node(-20, 80, 25, 75)
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

  local previousAnimation
  local dashCallback
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
    if not self.isDashing then
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
    else
      -- is character speed below or equal to max speed?
      if vector.length(self.velocityX, self.velocityY) <= self.speed then
        -- stop dashing
        self.isDashing = false

        -- hide particleSystem
        self.ps.visible = false

        self.body.animator:play(previousAnimation, 1)
        if dashCallback then dashCallback() end
      end
    end

    -- set previous x, y
    prevX, prevY = self.x, self.y
  end

  function self:attack(callback)
    if not self.body.animator:isPlaying("sword-shield-stab") then
      -- play soundeffect
      efMusic["hit"]:play()
      -- enable weapon
      self.weapon.collider:setActive(true)
      -- change animation
      self.body.animator:play("sword-shield-stab", 1, function()
        self.body.animator:play("sword-shield-idle", 0)
        -- disable weapon
        self.weapon.collider:setActive(false)

        -- invoke callback
        if callback then callback() end
      end)
    end
  end

  function self:dash(x, y, callback)
    -- play soundeffect
    efMusic["dash"..math.random(1,6)]:play()
    
    -- remember current animation
    previousAnimation = self.body.animator.animationName

    -- start dashing
    self.isDashing = true

    -- show particleSystem
    self.ps.visible = true

    -- apply velocity
    self.velocityX, self.velocityY = x * self.rollSpeed, y * self.rollSpeed

    -- play animation
    self.body.animator:play("unarmed-dash", 1)
    self.legs.animator:play("legs-dash", 1)

    -- rotate to dash direction
    local rotation = vector.angle(0, 1, self.velocityX, self.velocityY)
    self.body.rotation = rotation
    self.legs.rotation = rotation

    -- set callback
    dashCallback = callback
  end

  -- apply damage to character
  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health > 0 then
      efMusic["hurt-0"..math.random(1,3)]:play()
    elseif self.health <= 0 then
      self:kill()
      efMusic["hurtdie"..math.random(1,4)]:play()
    end
  end

  -- TODO: create inherit system for boolean 'active', so we don't need
  --       dedicated kill and revive methods for activationg and deactivation

  -- kill character
  function self:kill()
    self.weapon.active = false
    self.healthBar.active = false
    self.body.active = false
    self.legs.active = false
    self.ps.active = false
    self.active = false
  end

  -- revive character
  function self:revive()
    self.weapon.active = true
    self.healthBar.active = true
    self.body.active = true
    self.legs.active = true
    self.ps.active = true
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

return character
