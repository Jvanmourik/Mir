local function agent(node)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true

  self.state = "idle"


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local currentPoint, nextPoint
  local points
  local _isLooping
  local followPathCallback

  local destinationX, destinationY
  local minimumDistance = 60
  local _minimumDistance = minimumDistance
  local goToPointCallback

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if self.state == "walk" then
      local deltaX = destinationX - node.x
      local deltaY = destinationY - node.y
      if vector.length(deltaX, deltaY) > minimumDistance then
        local dirX, dirY = vector.normalize(deltaX, deltaY)
        -- apply input multiplied with speed to velocity
        node.x, node.y = node.x + dirX * node.speed * dt, node.y + dirY * node.speed * dt

        -- make node look at destination
        node.body:lookAt(node.x + dirX, node.y + dirY)
      else
        self.state = "idle"
        if goToPointCallback then goToPointCallback() end
      end
    end
  end

  -- let node move between given points
  function self:followPath(vertices, isLooping, callback)
    currentPoint = 1
    nextPoint = 2
    points = vertices
    _isLooping = isLooping
    followPathCallback = callback

    -- go to next point
    self:goToPoint(points[currentPoint + 1].x, points[currentPoint + 1].y, handleNextPoint)
  end

  -- moves node to given point
  function self:goToPoint(x, y, callback, r)
    self.state = "walk"
    destinationX = x
    destinationY = y
    goToPointCallback = callback
    minimumDistance = r or _minimumDistance
  end

  function self:stop()
    self.state = "idle"
  end


  ----------------------------------------------
  -- private methods
  ----------------------------------------------

  -- helper method to choose next point on path
  function handleNextPoint()
    -- check if followPath has ended
    if nextPoint == #points and not _isLooping then
      self.state = "idle"
      if followPathCallback then followPathCallback() end
      return
    end

    -- define direction
    local dir = (nextPoint - currentPoint)

    -- set currentPoint
    currentPoint = nextPoint

    -- define next point
    if dir > 0 and currentPoint < #points or currentPoint == 1 then
      nextPoint = nextPoint + 1
    elseif dir < 0 and currentPoint > 1 or currentPoint == #points then
      nextPoint = nextPoint - 1
    end

    -- go to next point
    self:goToPoint(points[nextPoint].x, points[nextPoint].y, handleNextPoint)
  end


  ----------------------------------------------
  return self
end

return agent
