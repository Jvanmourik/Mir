local Character = require "modules/character"
local Item = require "modules/item"
local Projectile = require "modules/projectile"
local Health = require "modules/health"

local function character(x, y, gamepad)
  local self = Character(x, y)
  local base = table.copy(self)

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "player"
  self.health = 300
  self.maxhealth = 300
  self.rollSpeed = 800
  local shootTimer = 0
  self.id = score:addPlayer()
  local hp = Health(self.x, self.y, self)
  --scene.rootNode:addChild(health)

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)

    -- direction vector
    local dirX, dirY = 0, 0

    if gamepad then
      -- gamepad input
      local leftX = gamepad:getAxis('leftx')
      local leftY = gamepad:getAxis('lefty')
      local rightX = gamepad:getAxis('rightx')
      local rightY = gamepad:getAxis('righty')

      -- normalize input
      if vector.length(leftX, leftY) > 0.3 then
        dirX, dirY = vector.normalize(leftX, leftY)
      end

      -- make character look at direction
      if vector.length(rightX, rightY) > 0.3 then
        self.body.rotation = vector.angle(0, 1, vector.normalize(rightX, rightY))
      end
    else
      -- keyboard input
      if input:isDown('a') or input:isDown('left') then dirX = -1 end
      if input:isDown('d') or input:isDown('right') then dirX = 1 end
      if input:isDown('w') or input:isDown('up') then dirY = -1 end
      if input:isDown('s') or input:isDown('down') then dirY = 1 end

      -- normalize input
      dirX, dirY = vector.normalize(dirX, dirY)

      -- make character look at direction
      self.body:lookAt(camera:mousePosition())
    end

    -- is character speed below or equal to max speed?
    if vector.length(self.velocityX, self.velocityY) <= self.speed then
      -- apply input multiplied with speed to velocity
      self.velocityX, self.velocityY = dirX * self.speed, dirY * self.speed

      -- character roll
      if vector.length(dirX, dirY) > 0.3 then
        if input:isPressed("space") or gamepad and gamepad:isPressed('b') then
          self.velocityX, self.velocityY = dirX * self.rollSpeed, dirY * self.rollSpeed
        end
      end
    end

    -- character attack
    if not gamepad and input:isPressed(1) or gamepad and gamepad:isPressed('rightshoulder') then
      self:attack()
    end
    -- pickup item on the ground
    if not gamepad and input:isPressed('e') or gamepad and gamepad:isPressed('x') then
      local item = self:pickupAnyItem()
      if item then
        self:throwItem(Item(self.weapon.id, self.x, self.y), 1000)
        self:equipItem(item)
      end
    end

    -- lower time you have to wait till you can shoot again
    shootTimer = shootTimer - 1
    -- call base update method
    base.update(self, dt)
  end

  function self:attack(callback)
    if self.weapon.type == "sword" then
      base.attack(self, callback)
    elseif self.weapon.type == "bow" and shootTimer <= 0 then
      dirX, dirY = self.body:getForwardVector()
      spawnX , spawnY = self.x + dirX * 50, self.y + dirY * 50
      shootTimer = 20
      local arrow = Projectile(spawnX, spawnY, dirX, dirY, self.weapon.damage)
      scene.rootNode:addChild(arrow)
    end
  end

  function self:pickupAnyItem()
    -- get items
    local items = scene.rootNode:getChildrenByTag("item")

    -- get closest item
    local closestItem
    local distance
    for _, item in pairs(items) do
      local d = vector.length(self.x - item.x, self.y - item.y)
      if not distance or d < distance then
        if item.active then
          distance = d
          closestItem = item
        end
      end
    end

    -- pickup item
    return self:pickupItem(closestItem)
  end

  local pickupDistance = 75
  function self:pickupItem(item)
    if item then
      local distance  = vector.length(self.x - item.x, self.y - item.y)

      -- check if item is in range
      if distance < pickupDistance then
        item.active = false
        return item
      end
    end
  end

  function self:equipItem(item)
    self.weapon.id = item.id
    self.weapon.name = item.name
    self.weapon.damage = item.damage
    self.weapon.type = item.type
  end

  function self:throwItem(item, force)
    local dirX, dirY = self.body:getForwardVector()
    item.velocityX, item.velocityY = dirX * force, dirY * force
    scene.rootNode:addChild(item)
  end


  ----------------------------------------------
  return self
end

return character
