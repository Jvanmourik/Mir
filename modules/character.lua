local Node = require "modules/node"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

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

  -- animator component to animate the sprite
  --[[self:addComponent("animator",
  { animations = assets.kramer.animations,
    animationName = "walk" })]]


  ----------------------------------------------
  -- child nodes
  ----------------------------------------------

  local graphic = Node()

  local assets = require "templates/assets"
  local character = assets.character
  local sprite = character.sword_shield.idle.frame
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()

  graphic.width = spriteWidth/4
  graphic.height = spriteHeight/4

  -- sprite renderer component to render the sprite
  graphic:addComponent("spriteRenderer",
  { atlas = "character.png",
    sprite = sprite,
    layer = layer })

  self:addChild(graphic)


  ----------------------------------------------

  local hitbox = Node(-10, 50, 25, 75, math.pi * 0)

  hitbox.anchorX, hitbox.anchorY = 0.5, 0
  hitbox:addComponent("collider")
  hitbox.collider.body:setActive(false)

  self:addChild(hitbox)


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
      local asset = character.sword_shield.stab
      local sprite = asset.frame
      local _, _, spriteWidth, spriteHeight = sprite:getViewport()
      local anchorX, anchorY = asset.anchorPoint

      graphic.sprite = sprite
      graphic.width = spriteWidth/4
      graphic.height = spriteHeight/4
      graphic.anchorX, graphic.anchorY = asset.anchorX, asset.anchorY

      hitbox.collider.body:setActive(true)
    else
      local asset = character.sword_shield.idle
      local sprite = asset.frame
      local _, _, spriteWidth, spriteHeight = sprite:getViewport()

      graphic.sprite = sprite
      graphic.width = spriteWidth/4
      graphic.height = spriteHeight/4
      graphic.anchorX, graphic.anchorY = asset.anchorX, asset.anchorY

      hitbox.collider.body:setActive(false)
    end

    -- make character look at direction
    self:lookAt(lm.getPosition())
  end

  function self:beginContact(f, contact)
    print("beginContact")
  end

  function self:endContact(f, contact)
    print("endContact")
  end


  ----------------------------------------------
  return self
end

return character
