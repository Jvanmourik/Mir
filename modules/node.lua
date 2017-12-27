local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Collider = require "modules/collider"

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

  -- get all parents recursively
  function self:getAllParents()
    return getAllParentsFrom(self)
  end

  -- get all children recursively
  function self:getAllChildren()
    return getAllChildrenFrom(self)
  end

  -- get child by name
  function self:getChild(name)
    for _, child in pairs(self:getAllChildren()) do
      if child.name == name then
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
      local c, s = math.cos(pr), math.sin(pr)
    	local x, y = self.x * c - self.y * s, self.x * s + self.y * c
    	return x + px, y + py
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
  function getAllParentsFrom(node)
    local parents = {}
    if node.parent then
      parents[#parents + 1] = node.parent
      table.combine(parents, getAllParentsFrom(node.parent))
    end
    return parents
  end

  -- helper method to get all children from given node recursively
  function getAllChildrenFrom(node)
    local children = {}
    for _, child in pairs(node.children) do
      children[#children + 1] = child
      if #child.children > 0 then
        table.combine(children, getAllChildrenFrom(child))
      end
    end
    return children
  end


  ----------------------------------------------
  return self

end

return node
