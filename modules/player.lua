local Character = require "modules/character"
local Item = require "modules/item"
local Projectile = require "modules/projectile"
local HealAura = require "modules/healAura"
local Boss = require "modules/boss"

local function character(x, y, gamepad)
  local self = Character(x, y)
  local base = table.copy(self)

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "player"
  self.playertype = ""
  self.health = 30
  self.maxhealth = 30
  local shootTimer = 0
  local healtimer = 90
  local healamount = 0
  local speedbuffTimer = 0
  local speedbuff = false

  --cooldowns
  local stunCDtimer = 0
  local healCDtimer = 0
  local speedCDtimer = 0
  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if not self.isDashing then
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

        -- character dash
        if vector.length(dirX, dirY) > 0.3 then
          if not gamepad and input:isPressed("space") or gamepad and gamepad:isPressed('b') then
            self:dash(dirX, dirY)
          end
        end
      end

      -- character attack
      if not gamepad and input:isPressed(1) or gamepad and gamepad:isPressed('rightshoulder') then
        self:attack()
      end

      -- character skill button
      if not gamepad and input:isPressed('r') or gamepad and gamepad:isPressed('a') then
        if self.playertype == "healer" then
          if healCDtimer <= 0 then
            local healAura = HealAura(self.x, self.y)
            scene.rootNode:addChild(healAura)
            healCDtimer = 1000
          end
        elseif self.playertype == "stunner" then
          if stunCDtimer <= 0 then
            local dirX, dirY = self.body:getForwardVector()
            local stunprojectile = Projectile(self.x, self.y, dirX, dirY, damage, "stunprojectile")
            scene.rootNode:addChild(stunprojectile)
            stunCDtimer = 300
          end
        elseif self.playertype == "speedBuffer" then
          if speedCDtimer <= 0 then
            speedbuff = true
            speedCDtimer = 600
            speedbuffTimer = 420
          end
        end
      end

      -- pickup item on the ground
      if not gamepad and input:isPressed('e') or gamepad and gamepad:isPressed('x') then
        local item = self:pickupAnyItem()
        if item then
          self:throwItem(Item(self.weapon.id, self.x, self.y), 1000)
          self:equipItem(item)
        end
      end
    end

    -- lower time you have to wait till you can shoot again
    shootTimer = shootTimer - 1
    --reduce duration speed boost
    speedbuffTimer = speedbuffTimer - 1
    -- Reduce time until you can use skills again
    healCDtimer = healCDtimer - 1
    stunCDtimer = stunCDtimer - 1
    speedCDtimer = speedCDtimer - 1

    --apply speed boost to all players within distance
    if speedbuff == true then
      if self.playertype == "speedBuffer" then
        for _, player in pairs(players) do
          local d = vector.length(player.x - self.x, player.y - self.y)
          if d <= 600 then
            player.speed = 800
          end
        end
        speedbuff = false;
      end
    end
    --reset speed from buff
    if speedbuffTimer <= 0 and speedCDtimer > 0 then
      for _, player in pairs(players) do
        player.speed = 400
      end
    end
    --make players able to be healed
    if ishealing == true then
      if healtimer ~= nil then healtimer = healtimer - 1
      else healtimer = 90
      end
      if healtimer <= 0 then
        if self.health < self.maxhealth then
          self.health = self.health + healamount
          healtimer = 90
        elseif self.health >= self.maxhealth then
          self.health = self.maxhealth
          healtimer = 90
        end
      end
    end

    -- call base update method
    base.update(self, dt)
  end

  --set values to start healing player
  function self:healing(heal, healTimer)
    healamount = heal
    healtimer = healTimer
    ishealing = true
  end
  --end the healing of a player
  function self:endhealing(healTimer)
    ishealing = false
    healtimer = healTimer
  end

  function self:attack(callback)
    if self.weapon.type == "sword" then
      base.attack(self, callback)
    elseif self.weapon.type == "bow" and shootTimer <= 0 then
      efMusic["hit"]:play()
      dirX, dirY = self.body:getForwardVector()
      spawnX , spawnY = self.x + dirX * 50, self.y + dirY * 50
      shootTimer = 20
      local arrow = Projectile(spawnX, spawnY, dirX, dirY, self.weapon.damage)
      scene.rootNode:addChild(arrow)
    end
  end



  function self:kill()
    base.kill(self)
    teamLives = teamLives - 1
    if teamLives > 0 then
      --base.revive(self)
      deathBoolean = true
      deathTimer = 2000
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
    --non finished code
    if self.playertype ~= "warrior" then
      self.weapon.damage = item.damage
    elseif self.playertype == "warrior" then
      self.weapon.damage = item.damage * 2
    end
    self.weapon.type = item.type
    if self.weapon.type == "bow" then
      self.body.animator:play("bow-idle", 0)
    else
      self.body.animator:play("sword-shield-idle", 0)
    end
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
