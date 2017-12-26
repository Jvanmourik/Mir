local function collider(node, options)
  local self = {}

  local bodyType = options.bodyType or "dynamic"
  local shapeType = options.shapeType or "rectangle"

  local x = node.x + (node.width * node.scaleX) * (0.5 - node.anchorX)
  local y = node.y + (node.height * node.scaleY) * (0.5 - node.anchorY)
  local width = options.width or node.width
  local height = options.height or node.height

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true

  if shapeType == "polygon" then
    self.shape = HC.polygon(options.vertices)
  elseif shapeType == "circle" then
    self.shape = HC.circle(x, y, options.radius)
  elseif shapeType == "rectangle" then
    self.shape = HC.rectangle(x, y, width * node.scaleX, height * node.scaleY)
  end


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
    self.shape:moveTo(x + offsetX, y + offsetY)
    self.shape:setRotation(r)
  end


  ----------------------------------------------
  return self
end

return collider
