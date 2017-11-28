local Node = require "modules/node"
Character = require "modules/character"
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
        -- TODO: add in a component system to call the component update method
        --       without having to manually add in every component in here

        -- update animator component
        if child.animator then
          child.animator:update(dt)
        end

        -- update node
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
      if child.spriteRenderer then
        drawableNodes[#drawableNodes + 1] = child
      end
    end

    -- sort all drawable nodes by layer
    table.sort(drawableNodes, function (a,b)
      return a.layer < b.layer
    end)

    -- draw all drawable nodes
    for _, node in pairs(drawableNodes) do
      local x, y = node:getWorldCoords()
      local r = node:getWorldRotation()
      node.spriteRenderer:draw(x, y, r)
    end
  end


  ----------------------------------------------
  return self
end

return scene
