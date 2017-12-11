local function collider(node, bodyType)
  local self = {}

  local bodyType = bodyType or "dynamic"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.body = lp.newBody(world)
  self.body:setType(bodyType)
  self.body:setSleepingAllowed(false)

  self.shape = lp.newRectangleShape(node.width, node.height)

  self.fixture = lp.newFixture(self.body, self.shape)
  self.fixture:setSensor(true)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    self:updateBody()
  end

  function self:updateBody()
    local x, y = node:getWorldCoords()
    local r = node:getWorldRotation()
    local offsetX = node.width * (0.5 - node.anchorX)
    local offsetY = node.height * (0.5 - node.anchorY)

    -- change offset based on rotation
    local c, s = math.cos(r), math.sin(r)
    offsetX, offsetY = offsetX * c - offsetY * s, offsetX * s + offsetY * c

    -- set position and rotation of the physic body
    self.body:setPosition(x + offsetX, y + offsetY)
    self.body:setAngle(r)
  end

  self:updateBody()
  

  ----------------------------------------------
  return self
end

return collider
