local function collider(node, bodyType)
  local self = {}

  local bodyType = bodyType or "dynamic"

  local previousX, previousY

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  local x = node.x + (node.width * node.scaleX) * (0.5 - node.anchorX)
  local y = node.y + (node.height * node.scaleY) * (0.5 - node.anchorY)

  self.body = lp.newBody(world, x, y, bodyType)
  self.body:setSleepingAllowed(false)

  self.shape = lp.newRectangleShape(node.width * node.scaleX,
    node.height * node.scaleY)

  self.fixture = lp.newFixture(self.body, self.shape)
  self.fixture:setSensor(true)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    local x, y = node:getWorldCoords()
    local r = node:getWorldRotation()
    local offsetX = (node.width * node.scaleX) * (0.5 - node.anchorX)
    local offsetY = (node.height * node.scaleY) * (0.5 - node.anchorY)

    -- change offset based on rotation
    local c, s = math.cos(r), math.sin(r)
    offsetX, offsetY = offsetX * c - offsetY * s, offsetX * s + offsetY * c

    -- set position and rotation of the physic body
    self.body:setPosition(x + offsetX, y + offsetY)
    self.body:setAngle(r)
  end


  ----------------------------------------------
  return self
end

return collider
