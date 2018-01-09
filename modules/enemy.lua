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

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { atlas = assets.character.atlas,
    asset = assets.character.unarmed.idle,
    layer = layer })

  -- animator component to animate the sprite
  --[[self:addComponent("animator",
  { animations = assets.kramer.animations,
    animationName = "walk" })]]

  -- collider component to collide with other collision objects
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 40
  })

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
    if not self.agent.pathing and self.target and vector.length(self.x - c.x, self.y - c.y) < 200 then
      self:lookAt(c.x, c.y)
    end
  end

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

  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  function self:kill()
    self.active = false
  end


  ----------------------------------------------
  return self
end

return enemy
