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


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 50,
    sensor = true
  })

  self:addComponent("spriteRenderer", {
    atlas = assets.items.atlas,
    asset = asset,
    layer = 0
  })


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  --[[function self:update(dt)
    if isAttacking and self.type == "bow" then
      print("shoot arrow")
    elseif isAttacking and self.type == "damageStaff" then
      print("cast damaging spell")
    elseif isAttacking and self.type == "healingStaff" then
      print("cast healing spell")
    end
  end]]


  ----------------------------------------------
  return self
end

return item
