local function collider(node, bodyType)
  local self = {}

  local bodyType = bodyType or "dynamic"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.body = lp.newBody(world, node.x + node.width * (0.5 - node.anchorX),
    node.y + node.height * (0.5 - node.anchorY), bodyType)
  self.shape = lp.newRectangleShape(node.width, node.height)
  self.fixture = lp.newFixture(self.body, self.shape)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    self.body:setPosition(node.x + node.width * (0.5 - 1),
      node.y + node.height * (0.5 - 1))
  end


  ----------------------------------------------
  return self
end

return collider
