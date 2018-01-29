local Character = require "modules/character"
local Item = require "modules/item"
local Projectile = require "modules/projectile"


local function enemy(x, y)
  local self = Character(x, y)
  local base = table.copy(self)

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "enemy"
  self.speed = 400
  self.health = 20
  self.maxhealth = 20
  local shootTimer = 0

  local weaponRandom = love.math.random()
  if weaponRandom < 0.3 then
    self.weapon.id = 2
    self.weapon.name = "regularBow"
    self.weapon.damage = 5
    self.weapon.type = "bow"
  end
  
  if self.weapon.type == "bow" then
    self.body.animator:play("bow-idle", 0)
  else
    self.body.animator:play("sword-shield-idle", 0)
  end
  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- agent component to implement AI
  self:addComponent("agent")


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local target
  local players
  local timer = 0
  local aggroDistance
  local minimumDistance
  local attackCooldown = 1500
  local isAttacking = false
  if self.weapon.type == "sword" then
    aggroDistance = 200
    minimumDistance = 100
  else
    aggroDistance = 400
    minimumDistance = 600
  end

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    -- get players
    if not players then
      players = scene.rootNode:getChildrenByName("player")
    end

    if self.health < self.maxhealth then
      aggroDistance = 1000
    end

    -- set closest player as target
    local distance
    for _, player in pairs(players) do
      if player.active then
        local d = vector.length(player.x - self.x, player.y - self.y)
        if not distance or d < distance then
          distance = d
          target = player
        end
      end
    end

    if target and target.active then
      local d = vector.length(target.x - self.x, target.y - self.y)

      -- if target in range
      if d < aggroDistance then
        -- move to target
        if d > minimumDistance and not isAttacking then
          self.agent:goToPoint(target.x, target.y)
        elseif self.agent.state == "walk" then
          self.agent:stop()
        end

        -- look at target if agent is idle
        if not isAttacking and self.agent.state == "idle" then
          self.body:lookAt(target.x, target.y)
        end

        -- attack
          if d < minimumDistance and timer <= 0 then
            isAttacking = true
            self:attack(function()
              isAttacking = false
            end)
            timer = attackCooldown
          end
      end

      -- update timer
      timer = timer - 1000 * dt
    end

    -- call base update method
    base.update(self, dt)
  end

  function self:attack(callback)
    if self.weapon.type == "sword" then
      base.attack(self, callback)
    elseif self.weapon.type == "bow" then
      local deltaX = target.x - self.x
      local deltaY = target.y - self.y
      local dirX, dirY = vector.normalize(deltaX, deltaY)
      spawnX , spawnY = self.x + dirX * 50, self.y + dirY * 50
      local arrow = Projectile(spawnX, spawnY, dirX, dirY, self.weapon.damage)
      scene.rootNode:addChild(arrow)
      -- invoke callback
      if callback then callback() end
    end
  end

  function self:kill()
    local randomNumber = love.math.random()
    local item
    if self.weapon.type == "sword" then
      if randomNumber <= 0.8 then
        item = Item(1, self.x, self.y)
      else
        item = Item(5, self.x, self.y)
      end
    else
      item = Item(2, self.x, self.y)
    end
    scene.rootNode:addChild(item)
    base.kill(self)
  end

  function self:moveToPoint(x, y, dt)
    local deltaX = x - self.x
    local deltaY = y - self.y
    local dirX, dirY = vector.normalize(deltaX, deltaY)

    -- apply input multiplied with speed to velocity
    self.x, self.y = self.x + dirX * self.speed * dt, self.y + dirY * self.speed * dt

    -- make node look at destination
    self.body:lookAt(self.x + dirX, self.y + dirY)
  end


  ----------------------------------------------
  return self
end

return enemy
