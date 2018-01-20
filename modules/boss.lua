local Node = require "modules/node"
local items = require "templates/items"
local assets = require "templates/assets"

local function boss(x,y)
  local self = Node(x,y)

  ---attributes
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

  self:addComponent("collider", {
    shapeType = "circle",
    radius = 50
  })

  --spriteRenderer (temp)
  --[[self.body = Node()
  self.body.scale = 0.5]]

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { atlas = assets.boss.atlas,
    asset = assets.boss.bossAsset,
    layer = 0 })

  -- animator component to animate the sprite
  --[[self.body:addComponent("animator",
  { animations = assets.character.animations })
  self.body.animator:play("sword-shield-idle", 0)

  self:addChild(self.body)]]

  --collision
  --[[self.hitbox = Node(-20, 80, 25, 75)
  self.hitbox.anchorX, self.hitbox.anchorY = 0.5, 0

  -- collider component to collide with other collision objects
  self.hitbox:addComponent("collider")
  self.hitbox.collider.active = false
  self.hitbox.collider.isSensor = true/]]

  --Add some AI
  --self:addComponent("agent")


  --functions / attacks

  --

  --update
  function self:update(dt)

  end
  return self
end

return boss
