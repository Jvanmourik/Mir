local function collider(node, options)
  local self = {}

  local shapeType = options.shapeType or "rectangle"

  local x = node.x + (node.width * node.scale) * (0.5 - node.anchorX)
  local y = node.y + (node.height * node.scale) * (0.5 - node.anchorY)
  local cx, cy = 0, 0
  local width = options.width or node.width
  local height = options.height or node.height

  local collisions = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true

  if shapeType == "polygon" then
    self.shape = HC.polygon(unpack(options.vertices))
    cx, cy = self.shape:center()
    self.shape:moveTo(x + cx, y + cy)
  elseif shapeType == "circle" then
    self.shape = HC.circle(x, y, options.radius)
  elseif shapeType == "rectangle" then
    self.shape = HC.rectangle(x, y, width, height)
  end
  self.shape:scale(node.scale)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
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

    self:handleCollisions(dt)
  end

  function self:handleCollisions(dt)
    -- check collision with other colliders
    local collisionsThisFrame = {}

    -- check if a collision has started
    for shape, delta in pairs(HC.collisions(self.shape)) do
      for _, other in pairs(scene.rootNode:getChildren()) do
        if other.collider and other.collider.active
          and other.collider.shape == shape then
          if node.onCollisionEnter and not collisions[shape] then
            node:onCollisionEnter(dt, other, delta)
          end
          if node.onCollision then
            node:onCollision(dt, other, delta)
          end
          collisions[other] = delta
          collisionsThisFrame[other] = delta
        end
      end
    end

    -- check if a collision has ended
    for other, delta in pairs(collisions) do
      if not collisionsThisFrame[other] then
        if node.onCollisionExit then
          node:onCollisionExit(dt, other, delta)
        end
        collisions[other] = nil
      end
    end
  end


  ----------------------------------------------
  return self
end

return collider
