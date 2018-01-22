local Node = require "modules/node"
local items = require "templates/items"
local assets = require "templates/assets"
local Projectile = require "modules/projectile"
local BossMinion = require "modules/bossMinion"
--local Character = require "modules/character"

local function boss(x,y)
  local self = Node(x, y)
  ---attributes
  local damage = 40
  self.health = 100
  self.name = "boss"
  self.speed = 100
  local fase = "regular"
  local timer = 60
  local faseDuration = 0
  local timer2 = 0
  local lockx, locky = 0, 0
  local lock = false
  local shake = false

  self.weapon = Node(0, 40, 25, 200)
  self.weapon.anchorX, self.weapon.anchorY = 0.5, 0

  -- add weapon template
  self.weapon.id = 1
  self.weapon.name = "regularSword"
  self.weapon.damage = 5
  self.weapon.type = "sword"

  -- collider component to collide with other collision objects
  self.weapon:addComponent("collider")
  self.weapon.collider.active = false
  self.weapon.collider.isSensor = true
  self:addChild(self.weapon)

  self:addComponent("collider", {
    shapeType = "circle",
    radius = 50
  })
  --self:addComponent("agent")

  function self:onCollisionEnter(dt, other, delta)
    bossMinions = scene.rootNode:getChildrenByName("bossMinion")
    if other.damage and type(other.damage) == "function" then
      for i=1, #bossMinions do
        if bossMinions[i] == other then
          return
        end
      end
      other:damage(damage)
    end
  end

  -- handle collision
  function self.weapon:onCollisionEnter(dt, other, delta)
    bossMinions = scene.rootNode:getChildrenByName("bossMinion")
    if other.damage and type(other.damage) == "function" then
      for i=1, #bossMinions do
        if bossMinions[i] == other then
          return
        end
      end
      other:damage(damage)
    end
  end
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

  local aggroDistance = 500
  --update
  function self:update(dt)
    if not players then
      players = scene.rootNode:getChildrenByName("player")
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
--hoi
    if target and target.active then
      local d = vector.length(target.x - self.x, target.y - self.y)

      -- if target in range
      if d < aggroDistance then
        if fase == "regular" then
          timer = timer - 1
          if timer <= 0 then
            number = love.math.random(1, 4)
            if number == 1 then
              fase = "eyeballShooting"
              faseDuration = 0
            elseif number == 2 then
              fase = "spinningAttack"
              timer = 300
            elseif number == 3 then
              fase = "spawnMinion"
              timer = 300
            elseif number == 4 then
              fase = "chargeAttack"
              timer = 90
              timer2 = 40
              shake = true
            end
          end
        elseif fase == "eyeballShooting" then
          if faseDuration >= 5 then
            fase = "regular"
            timer = 120
          end
          if timer <= 0 then
            faseDuration = faseDuration + 1
            timer = 30
            for i=1, 10 do
              local x, y = love.math.random(0, 10) - 5, love.math.random(0, 10) - 5
              local dirX, dirY = vector.normalize(x, y)
              local eyeball = Projectile(self.x, self.y, dirX, dirY, damage, "eyeball")
              scene.rootNode:addChild(eyeball)
              --[[if i < 3 then
                dirX = dirX - 1
              elseif i > 3 and i < 6 then
                dirX = dirX + 1
              elseif i == 3 then
                dirY = 0
              elseif i == 6 then
                dirY = -1
              else
                dirX = dirX - 1
              end]]
            end
          end
          timer = timer - 1
        elseif fase == "spinningAttack" then
          self.weapon.collider.active = true
          self.rotation = self.rotation + math.pi *dt
          local dX = target.x - self.x
          local dY = target.y - self.y
          local dirX, dirY = vector.normalize(dX, dY)

          self.x, self.y = self.x + dirX * self.speed * dt, self.y + dirY * self.speed * dt
          timer = timer - 1
          if timer <= 0 then
            fase = "regular"
            timer = 120
            self.rotation = 0
            self.weapon.collider.active = false
          end
        elseif fase == "spawnMinion" then
          for i=1, 4 do
            local x = self.x - 200 + i * 100
            local y = self.y - 200 + i * 100
            local minion = BossMinion(x, y)
            scene.rootNode:addChild(minion)
          end
          fase = "regular"
          timer = 120
        elseif fase == "chargeAttack" then
        timer = timer - 1
        if shake == true then
          if timer%10 == 0 then
            self.x = self.x - 5
          end
          if timer%10 == 5 then
            self.x = self.x + 5
          end
        end
        if timer <= 0 then
          timer2 = timer2 - 1
          shake = false
        end
        if  lock == false then
          if timer2 <= 20 then
            lock = true
            lockx, locky = target.x, target.y
          end
        end
        if timer2 <= 0 then
          local dX = lockx - self.x
          local dY = locky - self.y

          local dirX, dirY = vector.normalize(dX, dY)

          self.x, self.y = self.x + dirX * self.speed * 5 * dt, self.y + dirY * self.speed * 5 * dt

          if vector.length(dX, dY) < 10 then
            lock = false
            fase = "regular"
            timer = 120
          end
        end
        end
      end
    end
  end

  -- apply damage to character
  function self:damage(amount)
    local amount = amount or 1
    self.health = self.health - amount
    if self.health <= 0 then
      self:kill()
    end
  end

  -- TODO: create inherit system for boolean 'active', so we don't need
  --       dedicated kill and revive methods for activationg and deactivation

  -- kill character
  function self:kill()
    self.weapon.collider.active = false
    self.weapon = false
    self.active = false
  end


  return self
end

return boss
