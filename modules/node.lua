local function node(x, y)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true

  self.parent = nil
  self.children = {}
  self.components = {}

  self.x = x or 0
  self.y = y or 0


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- get x world coordinate
  function self:getWX()
    local wx = self.x
    for key, parent in pairs(self:getAllParents()) do
      wx = wx + parent.x
    end
    return wx
  end

  -- get y world coordinate
  function self:getWY()
    local wy = self.y
    for key, parent in pairs(self:getAllParents()) do
      wy = wy + parent.y
    end
    return wy
  end

  -- get all parents recursively
  function self:getAllParents()
    return getAllParentsFrom(self)
  end

  -- get all children recursively
  function self:getAllChildren()
    return getAllChildrenFrom(self)
  end

  -- add child to self.children
  function self:addChild(child)
    self.children[#self.children + 1] = child
    child.parent = self
  end


  ----------------------------------------------
  -- private methods
  ----------------------------------------------

  -- helper method to get all parent from given node recursively
  function getAllParentsFrom(node)
    local parents = {}
    if node.parent then
      parents[#parents + 1] = node.parent
      combineTables(parents, getAllParentsFrom(node.parent))
    end
    return parents
  end

  -- helper method to get all children from given node recursively
  function getAllChildrenFrom(node)
    local children = {}
    for key, child in pairs(node.children) do
      children[#children + 1] = child
      if #child.children > 0 then
        combineTables(children, getAllChildrenFrom(child))
      end
    end
    return children
  end

  -- helper method to combine two tables into one
  function combineTables(t1, t2)
    for key, value in pairs(t2) do
      t1[#t1 + 1] = value
    end
  end


  ----------------------------------------------
  return self
end

return node
