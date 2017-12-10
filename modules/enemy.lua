local Node = require "modules/node"

local function enemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"
  local sprite = assets.character.unarmed.idle.frame
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight
  self.scaleX = 0.25
  self.scaleY = 0.25
  self.anchorX = 0.5
  self.anchorY = 0.5


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { atlas = "character.png",
    sprite = sprite,
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
    if(lk.isDown("left")) then
      self.x = self.x - 250 * dt
    end
    if(lk.isDown("right")) then
      self.x = self.x + 250 * dt
    end
    if(lk.isDown("up")) then
      self.y = self.y - 250 * dt
    end
    if(lk.isDown("down")) then
      self.y = self.y + 250 * dt
    end

    -- make enemy look at character
    local c = scene.rootNode:getChild("character")
    self:lookAt(c.x, c.y)
  end


  ----------------------------------------------
  return self
end

return enemy
