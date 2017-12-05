local function agent(node)
  local self = {}
  screenwidth = 800
  screenheight= 600
  pd = false
  ----------------------------------------------
  -- methods
  ----------------------------------------------
  function self:update(dt)

  end
  function self:direction(target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    local dirX, dirY = vector.normalize(deltaX, deltaY)
    local length = vector.length(deltaX, deltaY)
    return dirX, dirY, length
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

  function self:charge(target, dirX, dirY, length)
    node.x = node.x + dirX * node.speed * length
    node.y = node.y + dirY * node.speed * length
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

  function self:patrolling(startx, endx, starty, endy)
    if(pd == false) then
      deltaX = endx - startx
      deltaY = endy - starty
    else
      deltaX = startx - endx
      deltaY = starty - endy
    end
    if(node.x >= endx and node.y >= endy) then
      pd = true
    elseif(node.x <= startx and node.y <= starty) then
      pd = false
    end
      local dirX, dirY = vector.normalize(deltaX, deltaY)
      node.x = node.x + dirX * node.speed
      node.y = node.y + dirY * node.speed
    end
  ----------------------------------------------
  return self
end

return agent
