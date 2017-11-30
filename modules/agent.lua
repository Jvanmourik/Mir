local function agent(node)
  local self = {}

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:follow(target)
    if(node.x > target.x) then
      node.x = node.x - 1
    else
      node.x = node.x + 1
    end
    if(node.y > target.y) then
      node.y = node.y - 1
    else
      node.y = node.y + 1
    end
  end

  function self:dodge(target)
    if(node.x > target.x) then
      node.x = node.x + 1
    else
      node.x = node.x - 1
    end
    if(node.y > target.y) then
      node.y = node.y + 1
    else
      node.y = node.y - 1
    end
  end


  ----------------------------------------------
  return self
end

return agent
