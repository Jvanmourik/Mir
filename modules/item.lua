local Node = require "modules/node"

local function item(id, x, y)
  local self = Node(x, y)

  local items = require "templates/items"
  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  local asset
  for _, item in pairs(items) do
    if item.id == id then
      self.id = item.id
      self.name = item.name
      self.damage = item.damage
      self.type = item.type
      asset = item.asset
    end
  end

  self.tag = "item"
  self.rotation = math.random() * 2 * math.pi

  self.velocityX, self.velocityY = 0, 0
  self.dragX, self.dragY = 8, 8


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  --[[self:addComponent("collider", {
    shapeType = "circle",
    radius = 50,
    sensor = true
  })]]

  self:addComponent("spriteRenderer", {
    atlas = assets.items.atlas,
    asset = asset,
    layer = 0
  })


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- add velocity to position
    self.x = self.x + self.velocityX * dt
    self.y = self.y + self.velocityY * dt

    -- apply drag to velocity
    self.velocityX = self.velocityX * (1 - self.dragX * dt)
    self.velocityY = self.velocityY * (1 - self.dragY * dt)

    -- rotate
    self.rotation = self.rotation + 0.25 * math.pi * dt
  end


  ----------------------------------------------
  return self
end

return item
