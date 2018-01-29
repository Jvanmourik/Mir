local function collider(node, options)
  local self = {}

  local shapeType = options.shapeType or "rectangle"

  local x = node.x + (node.width * node.scale) * (0.5 - node.anchorX)
  local y = node.y + (node.height * node.scale) * (0.5 - node.anchorY)
  local width = options.width or node.width
  local height = options.height or node.height

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true
  self.isKinematic = true
  self.isSensor = options.sensor or false
  self.isColliding = false
  self.collisions = {}

  local cx, cy = 0, 0
  if shapeType == "polygon" then
    self.shape = HC.polygon(unpack(options.vertices))
    cx, cy = self.shape:center()
    self.shape:moveTo(x + cx, y + cy)
  elseif shapeType == "circle" then
    self.shape = HC.circle(x, y, options.radius)
  elseif shapeType == "ellipse" then
    self.shape = HC.circle(x, y, 0.5 * width)
  elseif shapeType == "rectangle" then
    self.shape = HC.rectangle(x, y, width, height)
  end
  self.shape:scale(node.scale)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local collisionsThisFrame = {}

  function self:update(dt)
    if self.isKinematic then
      local x, y = node:getWorldCoords()
      local r = node:getWorldRotation()
      local offsetX = (node.width * node.scale) * (0.5 - node.anchorX)
      local offsetY = (node.height * node.scale) * (0.5 - node.anchorY)

      -- change offset based on rotation
      local c, s = math.cos(r), math.sin(r)
      offsetX, offsetY = offsetX * c - offsetY * s, offsetX * s + offsetY * c

      -- set position and rotation of the physic body
      self.shape:moveTo(x + offsetX + cx, y + offsetY + cy)
      self.shape:setRotation(r)

      -- reset the active collisions
      collisionsThisFrame = {}

      -- check if a collision event has occured
      self:handleEnteringCollisions()
      self:handleExitingCollisions()
    end
  end

  function self:setActive(boolean)
    self.active = boolean
    if boolean == false then
      self.collisions = {}
      self:handleExitingCollisions()
    end
  end

  -- check if a collision has started
  function self:handleEnteringCollisions()
    for shape, delta in pairs(HC.collisions(self.shape)) do
      for _, other in pairs(scene.collisionObjects) do
        local col = other.collider
        if other.active and col and col.active and not col.isSensor and col.shape == shape then
          self.isColliding = true
          if not self.collisions[other] and node.onCollisionEnter then
            node:onCollisionEnter(dt, other, delta)
          end
          if node.onCollision then
            node:onCollision(dt, other, delta)
          end
          self.collisions[other] = delta
          collisionsThisFrame[other] = delta
        end
      end
    end
  end

  -- check if a collision has ended
  function self:handleExitingCollisions()
    for other, delta in pairs(self.collisions) do
      if not collisionsThisFrame[other] then
        if node.onCollisionExit then
          node:onCollisionExit(dt, other, delta)
        end
        self.collisions[other] = nil
        if #self.collisions == 0 then
          self.isColliding = false
        end
      end
    end
  end


  ----------------------------------------------
  return self
end

return collider
