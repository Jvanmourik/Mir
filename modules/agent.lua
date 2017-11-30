local function agent(node)
  local self = {}

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:follow(target)
    if(node.x > target.x) then
      node.x = node.x - 5
    else
      node.x = node.x + 5
    end
    if(node.y > target.y) then
      node.y = node.y - 5
    else
      node.y = node.y + 5
    end
  end

  function self:dodge(target)
    if(node.x > target.x) then
      node.x = node.x + 5
    else
      node.x = node.x - 5
    end
    if(node.y > target.y) then
      node.y = node.y + 5
    else
      node.y = node.y - 5
    end
  end


  ----------------------------------------------
  return self
end

return agent
