local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Collider = require "modules/collider"
local Agent = require "modules/agent"

local function node(x, y, w, h, r, s, ax, ay, l)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true
  self.toBeRemoved = false

  self.parent = nil
  self.children = {}

  self.components = {}

  self.layer = l or 0

  self.x, self.y = x or 0, y or 0
  self.width, self.height = w or 0, h or 0
  self.rotation = r or 0
  self.scale = s or 1
  self.anchorX, self.anchorY = ax or 0, ay or 0


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- get parents recursively
  function self:getParents()
    return getParentsFrom(self)
  end

  -- get children recursively
  function self:getChildren()
    return getChildrenFrom(self)
  end

  -- get children by name
  function self:getChildrenByName(name)
    local children = {}
    for _, child in pairs(getChildrenFrom(self)) do
      if child.name == name then
        children[#children + 1] = child
      end
    end
    return children
  end

  -- get children by type
  function self:getChildrenByType(type)
    local children = {}
    for _, child in pairs(getChildrenFrom(self)) do
      if child.type == type then
        children[#children + 1] = child
      end
    end
    return children
  end

  -- get children by tag
  function self:getChildrenByTag(tag)
    local children = {}
    for _, child in pairs(getChildrenFrom(self)) do
      if child.tag == tag then
        children[#children + 1] = child
      end
    end
    return children
  end

  -- get child by name
  function self:getChildByName(name)
    for _, child in pairs(self:getChildren()) do
      if child.name == name then
        return child
      end
    end
  end

  -- get child by type
  function self:getChildByType(type)
    for _, child in pairs(self:getChildren()) do
      if child.type == type then
        return child
      end
    end
  end

  -- get child by tag
  function self:getChildByTag(tag)
    for _, child in pairs(self:getChildren()) do
      if child.tag == tag then
        return child
      end
    end
  end

  -- add child to self.children
  function self:addChild(child)
    self.children[#self.children + 1] = child
    child.parent = self
  end

  -- get coordinates in world space
  function self:getWorldCoords()
    if self.parent then
      local px, py = self.parent:getWorldCoords()
      local pr = self.parent:getWorldRotation()
      local ps = self.parent:getWorldScale()
      local c, s = math.cos(pr), math.sin(pr)
    	local x, y = self.x * c - self.y * s, self.x * s + self.y * c
    	return x * ps + px, y * ps + py
    else
      return self.x, self.y
    end
  end

  -- get rotation in world space
  function self:getWorldRotation()
    if self.parent then
      return self.rotation + self.parent:getWorldRotation()
    else
      return self.rotation
    end
  end

  -- get scale in world space
  function self:getWorldScale()
    if self.parent then
      return self.scale * self.parent:getWorldScale()
    else
      return self.scale
    end
  end

  function self:getForwardVector()
    local r = self.rotation + 0.5 * math.pi
    return math.cos(r), math.sin(r)
  end

  -- add component to self.components and self.<type>
  function self:addComponent(type, options)
    local options = options or {}
    local c
    if type == "spriteRenderer" then
      c = SpriteRenderer(self, options.atlas, options.asset, options.layer)
      self.spriteRenderer = c
    elseif type == "animator" then
      c = Animator(self, options.animations)
      self.animator = c
    elseif type == "collider" then
      c = Collider(self, options)
      self.collider = c
      scene.collisionObjects[#scene.collisionObjects + 1] = self
    elseif type == "agent" then
      c = Agent(self, options)
      self.agent = c
    end
    self.components[#self.components + 1] = c
  end

  -- rotate the node to make it look at a position
  function self:lookAt(x, y)
    local sx, sy = self:getWorldCoords()
    local dx, dy = x - sx, y - sy
    self.rotation = vector.angle(0, 1, dx, dy)
  end


  ----------------------------------------------
  -- private methods
  ----------------------------------------------

  -- helper method to get all parent from given node recursively
  function getParentsFrom(node)
    local parents = {}
    if node.parent then
      parents[#parents + 1] = node.parent
      table.combine(parents, getParentsFrom(node.parent))
    end
    return parents
  end

  -- helper method to get all children from given node recursively
  function getChildrenFrom(node)
    local children = {}
    for _, child in pairs(node.children) do
      children[#children + 1] = child
      if #child.children > 0 then
        table.combine(children, getChildrenFrom(child))
      end
    end
    return children
  end


  ----------------------------------------------
  return self

end

return node
