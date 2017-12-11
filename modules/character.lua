local Node = require "modules/node"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 40
  self.height = 50
  self.anchorX = 0.5
  self.anchorY = 0.5


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  self:addComponent("collider")


  ----------------------------------------------
  -- child nodes
  ----------------------------------------------

  local graphic = Node()

  graphic.scaleX = 0.25
  graphic.scaleY = 0.25

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
    collider:damage()
  end

  function hitbox:endContact(f, contact)
    print("endContact")
  end


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- character movement
    if(lk.isDown("a")) then
      self.x = self.x - 250 * dt
    end
    if(lk.isDown("d")) then
      self.x = self.x + 250 * dt
    end
    if(lk.isDown("w")) then
      self.y = self.y - 250 * dt
    end
    if(lk.isDown("s")) then
      self.y = self.y + 250 * dt
    end

    -- character attack
    if(lm.isDown(1)) then
      -- play animation
      graphic.animator:play("sword-shield-stab", 1, function () print("klaar") end)

      -- enable hitbox
      hitbox.collider.body:setActive(true)
    end

    -- make character look at direction
    self:lookAt(lm.getPosition())
  end


  ----------------------------------------------
  return self
end

return character
