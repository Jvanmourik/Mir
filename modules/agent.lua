local function agent(node)
  local self = {}
  local screenwidth = 800
  local screenheight= 600
  local pbool = false
  local cbool = false
  local ctimer = 60
  local dirX, dirY, length
  local deltaX, deltaY

  local pathing = false
  local mirror = false
  local isLooping = false
  local currentPoint
  local vertices
  local isWalking = false
  local _callback
  local endX, endY

  local following = false
  local radius
  local target

  local avoiding = false
  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true


  ----------------------------------------------
  -- methods
  ----------------------------------------------
  function self:update(dt)
    if pathing then
      local deltaX = endX - node.x
      local deltaY = endY - node.y
      local distanceToPoint = vector.length(deltaX, deltaY)
      if distanceToPoint < 30 then
        if mirror then
          currentPoint = currentPoint - 1
        else
          currentPoint = currentPoint + 1
        end
        _callback()
      else
        local dirX, dirY = vector.normalize(deltaX, deltaY)
        node.x = node.x + dirX * node.speed * dt
        node.y = node.y + dirY * node.speed * dt
        node:lookAt(node.x + dirX, node.y + dirY)
      end
    end

    if following  then
      if self:area(radius, target) then
        self:goToPoint(target.x, target.y, dt)
      end
    end

    if avoiding  then
      if self:area(radius, target) then
        self:goToPoint(-target.x, -target.y, dt)
      end
    end
  end

  --[[function self:direction(target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    local dirX, dirY = vector.normalize(deltaX, deltaY)
    local length = vector.length(deltaX, deltaY)
    return dirX, dirY, length
  end]]

  function self:followTarget(_target, _radius)
    following = true
    radius = _radius
    target = _target
  end

  function self:goToPoint(x, y, dt)
    local deltaX = x - node.x
    local deltaY = y - node.y
    if(vector.length(deltaX, deltaY) > 20) then
      local dirX, dirY = vector.normalize(deltaX, deltaY)
      node.x = node.x + dirX * node.speed * dt
      node.y = node.y + dirY * node.speed * dt
    end
  end

  function self:followPath(pathNode, isLooping)
    pathing = true
    currentPoint = 1
    vertices = pathNode.vertices

    self:goToPathPoint(vertices[currentPoint + 1].x, vertices[currentPoint + 1].y, handleNextPoint)
  end

  function handleNextPoint()
    if currentPoint < #vertices and not mirror then
      self:goToPathPoint(vertices[currentPoint + 1].x, vertices[currentPoint + 1].y, handleNextPoint)
    elseif currentPoint > 1 and mirror then
      self:goToPathPoint(vertices[currentPoint - 1].x, vertices[currentPoint - 1].y, handleNextPoint)
    elseif currentPoint == #vertices and not mirror then
      mirror = true
      self:goToPathPoint(vertices[currentPoint - 1].x, vertices[currentPoint - 1].y, handleNextPoint)
    elseif currentPoint == 1 and mirror then
      mirror = false
      self:goToPathPoint(vertices[currentPoint + 1].x, vertices[currentPoint + 1].y, handleNextPoint)
    else
      pathing = false
    end
  end

  function self:goToPathPoint(x, y, callback)
    endX, endY = x, y
    isWalking = true
    _callback = callback
  end

  function self:avoidTarget(_target, _radius)
    avoiding = true
    radius = _radius
    target = _target
  end

  --[[function self:charge(target)
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
  end]]

  function self:area(radius, target)
    local deltaX = target.x - node.x
    local deltaY = target.y - node.y
    if(vector.length(deltaX, deltaY) <= radius) then
      return true
    end
    return false
  end

  --[[function self:insideScreen(target)
    if(target.x + target.width <= screenwidth and target.x >= 0 and target.y + target.height <= screenheight and target.y >= 0) then
      return true
    end
      return false
  end]]

  --[[function self:patrolling(startx, endx, starty, endy)
    local deltaX, deltaY
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
      local dirX, dirY = vector.normalize(deltaX, deltaY)
      node.x = node.x + dirX * node.speed
      node.y = node.y + dirY * node.speed
    end]]
  ----------------------------------------------
  return self
end

return agent
