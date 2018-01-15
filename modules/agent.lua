local function agent(node)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  local state = "idle"
  local destinationX, destinationY
  local minimumDistance = 60
  local _callback

  -- update function called each frame, dt is time since last frame
  function self:update(dt)

    if state == "moving" then
      local deltaX = destinationX - node.x
      local deltaY = destinationY - node.y
      if vector.length(deltaX, deltaY) > minimumDistance then
        local dirX, dirY = vector.normalize(deltaX, deltaY)
        -- apply input multiplied with speed to velocity
        node.x, node.y = node.x + dirX * node.speed * dt, node.y + dirY * node.speed * dt

        -- make node look at destination
        node.body:lookAt(node.x + dirX, node.y + dirY)
      else
        state = "idle"
        if _callback then _callback() end
      end
    end

  end

  -- moves node to given point
  function self:goToPoint(x, y, r, callback)
    state = "moving"
    destinationX = x
    destinationY = y
    if r then minimumDistance = r end
    _callback = callback
  end


  ----------------------------------------------
  return self
end

return agent
