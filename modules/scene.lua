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
        if child.toBeRemoved then
          -- disable node
          child.active = false

          -- disable node collider
          if child.collider then
            child.collider.body:setActive(false)
          end
        else
          -- update node
          if child.update then
            child:update(dt)
          end

          -- update all node components
          for _, component in pairs(child.components) do
            if component.update then
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
    for _, child in pairs(self.rootNode:getAllChildren()) do
      if child.active and child.spriteRenderer then
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

    -- draw all collision shapes
    for _, node in pairs(self.rootNode:getAllChildren()) do
      if node.collider then
        lg.setColor(32,130,230, 100)
        node.collider.shape:draw('fill')
        lg.setColor(255,255,255)
      end
    end
  end


  ----------------------------------------------
  return self
end

return scene
