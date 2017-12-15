local Node = require "modules/node"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 80
  self.height = 100
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

  local hitbox = Node(-20, 100, 50, 150, math.pi * 0)

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
    -- character movement
    if input:isDown('a') then
      self.x = self.x - 500 * dt
    end
    if input:isDown('d') then
      self.x = self.x + 500 * dt
    end
    if input:isDown('w') then
      self.y = self.y - 500 * dt
    end
    if input:isDown('s') then
      self.y = self.y + 500 * dt
    end

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

    -- make character look at direction
    self:lookAt(lm.getPosition())
  end


  ----------------------------------------------
  return self
end

return character
