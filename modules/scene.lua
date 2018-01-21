local Node = require "modules/node"

local function scene(...)
  local self = {}

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- root node of the node graph
  self.rootNode = Node(...)
  self.collisionObjects = {}


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    -- update all nodes
    for _, child in pairs(self.rootNode:getChildren()) do
      if child.active then
        if child.toBeRemoved then
          -- disable node
          child.active = false

          -- disable node collider
          if child.collider then
            child.collider.active = false
          end
        else
          -- update node
          if child.update then
            child:update(dt)
          end

          -- update all node components
          for _, component in pairs(child.components) do
            if component.active and component.update then
              component:update(dt)
            end
          end
        end
      end
    end
  end

  function self:draw()
    -- TODO: sort drawableNodes only when node.layer gets set
    --       instead of every frame

    -- get all drawable nodes
    local drawableNodes = {}
    for _, child in pairs(self.rootNode:getChildren()) do
      if child.active and child.visible and child.spriteRenderer then
        drawableNodes[#drawableNodes + 1] = child
      end
    end

    -- sort all drawable nodes by layer
    table.sort(drawableNodes, function (a,b)
      return a.layer < b.layer
    end)

    -- draw all drawable nodes
    for _, node in pairs(drawableNodes) do
      node.spriteRenderer:draw()
    end
  end


  ----------------------------------------------
  return self
end

return scene
