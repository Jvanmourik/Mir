local Node = require "modules/node"

local function scene(...)
  local self = {}

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- root node of the node graph
  self.rootNode = Node(...)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- update all nodes
    for _, child in pairs(self.rootNode:getAllChildren()) do
      if child.active then
        child:update(dt)
      end
    end
  end

  function self:draw()
    -- TODO: sort drawableNodes only when node.layer gets set
    --       instead of every frame

    -- get all drawable nodes
    local drawableNodes = {}
    for _, child in pairs(self.rootNode:getAllChildren()) do
      if child.graphic then
        drawableNodes[#drawableNodes + 1] = child
      end
    end

    -- sort all drawable nodes by layer
    table.sort(drawableNodes, function (a,b)
      return a.graphic.layer < b.graphic.layer
    end)

    -- draw all drawable nodes
    for _, node in pairs(drawableNodes) do
      local x, y = node:getWorldCoords()
      local r = node:getWorldRotation()
      node.graphic:draw(x, y, r)
    end
  end


  ----------------------------------------------
  return self
end

return scene
