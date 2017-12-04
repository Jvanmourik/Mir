local function agent(node)
  local self = {}
  screenwidth = 800
  screenheight= 600
  ----------------------------------------------
  -- methods
  ----------------------------------------------
  function self:update(dt)

  end
  function self:direction(target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    local dirX, dirY = vector.normalize(deltaX, deltaY)
    return dirX, dirY
  end

  function self:follow(target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    if(vector.length(deltaX, deltaY) > 20) then
    local dirX, dirY = vector.normalize(deltaX, deltaY)
    node.x = node.x + dirX * node.speed
    node.y = node.y + dirY * node.speed
  end
    --[[if(node.x > target.x and node.x > target.x + 25) then
      node.x = node.x - node.x * angle
    elseif(node.x < target.x - 25) then
      deltax = target.x - node.x
      deltay = target.y - node.y
      angle = math.atan2(deltax, deltay)
      node.x = node.x + node.x * angle
    end
    if(node.y > target.y and node.y > target.y + 25) then
      deltax = node.x - target.x
      deltay = node.y - target.y
      angle = math.atan2(deltax, deltay)
      node.y = node.y - node.y * angle
    elseif(node.y < target.y - 25) then
      deltax = target.x - node.x
      deltay = target.y - node.y
      angle = math.atan2(deltax, deltay)
      node.y = node.y + node.y * angle
    end]]
  end
  function self:dodge(target)
    self:direction(target)
    node.x = node.x - dirX * node.speed
    node.y = node.y - dirY * node.speed
  --end
end

  function self:charge(target, dirX, dirY)
    node.x = node.x + dirX * node.speed * 5
    node.y = node.y + dirY * node.speed * 5
  end

  function self:area(radius, target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    if(vector.length(deltaX, deltaY) <= radius) then
      return true
    end
    return false
  end
  function self:insideScreen(target)
    if(target.x + target.width <= screenwidth and target.x >= 0 and target.y + target.height <= screenheight and target.y >= 0) then
    return true
  end
  return false
  end
  ----------------------------------------------
  return self
end

return agent
