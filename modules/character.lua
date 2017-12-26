local Node = require "modules/node"

local function character(x, y, gamepad)
  local self = Node(x, y)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "character"
  self.width = 40
  self.height = 40
  self.anchorX = 0.5
  self.anchorY = 0.5

  self.speed = 400


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- collider component to collide with other collision objects
  self:addComponent("collider")


  ----------------------------------------------
  -- child nodes
  ----------------------------------------------

  local legs = Node()

  legs.scaleX = 0.5
  legs.scaleY = 0.5

  -- sprite renderer component to render the sprite
  legs:addComponent("spriteRenderer",
  { atlas = "images/character.png",
    asset = assets.character.legs.idle,
    layer = 0 })

  -- animator component to animate the sprite
  legs:addComponent("animator",
  { animations = assets.character.animations })
  legs.animator:play("legs-idle", 0)

  self:addChild(legs)


  ----------------------------------------------

  local body = Node()

  body.scaleX = 0.5
  body.scaleY = 0.5

  -- sprite renderer component to render the sprite
  body:addComponent("spriteRenderer",
  { atlas = "images/character.png",
    asset = assets.character.sword_shield.idle,
    layer = 1 })

  -- animator component to animate the sprite
  body:addComponent("animator",
  { animations = assets.character.animations })
  body.animator:play("sword-shield-idle", 0)

  self:addChild(body)


  ----------------------------------------------

  local hitbox = Node(-10, 50, 25, 75)

  hitbox.anchorX, hitbox.anchorY = 0.5, 0
  hitbox:addComponent("collider")
  --hitbox.collider.body:setActive(false)

  body:addChild(hitbox)

  function hitbox:beginContact(f, contact)
    local collider = f:getUserData()
    if collider.name == "enemy" then
      collider:damage()
    end
  end

  function hitbox:endContact(f, contact)
    --print("endContact")
  end


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if gamepad then -- gamepad

      -- input
      local leftX = gamepad:getAxis('leftx')
      local leftY = gamepad:getAxis('lefty')
      local rightX = gamepad:getAxis('rightx')
      local rightY = gamepad:getAxis('righty')

      -- left analog stick
      if vector.length(leftX, leftY) > 0.3 then
        local dirX, dirY = vector.normalize(leftX, leftY)

        -- character movement
        self.x = self.x + self.speed * dt * leftX
        self.y = self.y + self.speed * dt * leftY

        -- rotate legs at walking direction
        legs.rotation = vector.angle(0, 1, dirX, dirY)

        -- animated legs
        if not legs.animator:isPlaying("legs-walk") then
          legs.animator:play("legs-walk", 0)
        end
      elseif not legs.animator:isPlaying("legs-idle") then
        legs.animator:play("legs-idle", 0)
      end

      -- right analog stick
      if vector.length(rightX, rightY) > 0.3 then
        local dirX, dirY = vector.normalize(rightX, rightY)

        -- make character look at direction
        body.rotation = vector.angle(0, 1, dirX, dirY)
      end

      -- character attack
      if gamepad:isPressed('rightshoulder') and not body.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        --hitbox.collider.body:setActive(true)

        -- change animation
        body.animator:play("sword-shield-stab", 1, function()
          body.animator:play("sword-shield-idle", 0)
          --hitbox.collider.body:setActive(false)
        end)
      end

    else -- keyboard and mouse

      -- input
      local dirX, dirY = 0, 0
      if input:isDown('a') or input:isDown('left') then dirX = -1 end
      if input:isDown('d') or input:isDown('right') then dirX = 1 end
      if input:isDown('w') or input:isDown('up') then dirY = -1 end
      if input:isDown('s') or input:isDown('down') then dirY = 1 end

      -- normalize input
      dirX, dirY = vector.normalize(dirX, dirY)

      -- arrow keys
      if vector.length(dirX, dirY) > 0 then
        -- character movement
        self.x = self.x + self.speed * dt * dirX
        self.y = self.y + self.speed * dt * dirY

        -- rotate legs at walking direction
        legs.rotation = vector.angle(0, 1, dirX, dirY)

        -- animate legs
        if not legs.animator:isPlaying("legs-walk") then
          legs.animator:play("legs-walk", 0)
        end
      elseif not legs.animator:isPlaying("legs-idle") then
        legs.animator:play("legs-idle", 0)
      end

      -- make character look at direction
      body:lookAt(lm.getPosition())

      -- character attack
      if input:isPressed(1) and not body.animator:isPlaying("sword-shield-stab") then
        -- enable hitbox
        --hitbox.collider.body:setActive(true)

        -- change animation
        body.animator:play("sword-shield-stab", 1, function()
          body.animator:play("sword-shield-idle", 0)
          --hitbox.collider.body:setActive(false)
        end)
      end

    end
  end

  function self:beginContact(f, contact)
    local collider = f:getUserData()
    if collider.name == "unreachable" then
      --print(contact:getSeparation())
      local nx, ny = contact:getNormal()
      if x2 then
      local x1, y1, x2, y2 = contact:getPositions()

      local distance = vector.length(x1 - x2, y1 - y2)
      local tx, ty = nx * distance, ny * distance

      self.x = self.x + tx
      self.y = self.y + ty
    end
    end
  end


  ----------------------------------------------
  return self
end

return character
