local function agent(node)
  local self = {}
  local screenwidth = 800
  local screenheight= 600
  local pbool = false
  local cbool = false
  local ctimer = 60
  local dirX, dirY, length
  local deltaX, deltaY
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

  function self:followPath(vertices)
    local n = 1
    local startX, endX, startY, endY = vertices[n], vertices[n + 2], vertices[n + 1], vertices[n + 3]
    local deltaX = vertices[n + 2] - vertices[n]
    local deltaY = vertices[n + 3] - vertices[n+ 1]
    local length = vector.length(startx - node.x, starty - node.y)
  end

  function self:dodge(target)
    self:direction(target)
    node.x = node.x - dirX * node.speed
    node.y = node.y - dirY * node.speed
  --end
  end

  function self:charge(target)
    if(cbool == false) then
      dirX, dirY, length = self:direction(target)
      cbool = true
    end
    if(length >= 0) then
      node.x = node.x + dirX * node.speed * 5
      node.y = node.y + dirY * node.speed * 5
      length = length - vector.length(dirX, dirY) * node.speed * 5
    else
      ctimer = ctimer - 1
      if(ctimer <= 0) then
        cbool = false
        ctimer = 60
      end
    end
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
    if(pbool == false) then
      deltaX = endx - startx
      deltaY = endy - starty
      length = vector.length(endx - node.x, endy - node.y)
    else
      deltaX = startx - endx
      deltaY = starty - endy
      length = vector.length(startx - node.x, starty - node.y)
    end
    if(length <= 0 and pbool == false) then
      pbool = true
    elseif(length <= 0 and pbool) then
      pbool = false
    end
    --[[if(node.x >= endx and node.y >= endy) then
      pbool = true
    elseif(node.x <= startx and node.y <= starty) then
      pbool = false
    end]]
      local dirX, dirY = vector.normalize(deltaX, deltaY)
      node.x = node.x + dirX * node.speed
      node.y = node.y + dirY * node.speed
    end
  ----------------------------------------------
  return self
end

return agent
