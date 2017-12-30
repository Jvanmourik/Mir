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
  self:addComponent("collider")


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- make enemy look at character in a certain range
    local c = scene.rootNode:getChild("character")
    if c and vector.length(self.x - c.x, self.y - c.y) < 200 then
      self:lookAt(c.x, c.y)
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
