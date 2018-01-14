local Node = require "modules/node"

local function enemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------



  self.name = "enemy"
  self.scale = 0.5

  self.health = 1
  self.speed = 100
  self.timer = 0
  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  local body = Node()

  -- sprite renderer component to render the sprite
  body:addComponent("spriteRenderer",
  { atlas = assets.character.atlas,
    asset = assets.character.sword_shield.idle,
    layer = 1 })

  -- animator component to animate the sprite
  body:addComponent("animator",
  { animations = assets.character.animations })
  body.animator:play("sword-shield-idle", 0)

  self:addChild(body)


  -- collider component to collide with other collision objects
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 40
  })

  local hitbox = Node(-20, 80, 25, 75)
  hitbox.anchorX, hitbox.anchorY = 0.5, 0

  hitbox:addComponent("collider")
  hitbox.collider.active = false

  body:addChild(hitbox)

  function hitbox:onCollisionEnter(dt, other, delta)
    if other.name == "character" then
      other:damage()
    end
  end

  function hitbox:endContact(f, contact)
    --print("endContact")
  end

  -- agent component to implement AI
  self:addComponent("agent")

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if not self.target then
      self.target = scene.rootNode:getChildByName("character")
    end

    -- make enemy look at character in a certain range
    if self.target and vector.length(self.x - c.x, self.y - c.y) < 200  and c.active then
      if not body.animator:isPlaying("sword-shield-stab") then
        self:lookAt(c.x, c.y)
      end
      if self.timer <= 0 then
        -- enable hitbox
        hitbox.collider.active = true

        -- change animation
        if not body.animator:isPlaying("sword-shield-stab") then
          body.animator:play("sword-shield-stab", 1, function()
            body.animator:play("sword-shield-idle", 0)
            hitbox.collider.active = false
            self.timer = 60
          end)
        end
      end
    end
    self.timer = self.timer - 1
  end

  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  function self:kill()
    if not body.animator:isPlaying("sword-shield-stab") then
      body.active = false
      self.active = false
    end
  end


  ----------------------------------------------
  return self
end

return enemy
