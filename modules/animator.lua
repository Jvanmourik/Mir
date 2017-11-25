local function animator(node, animations, animation, frame)
  local self = {}

  local animation = animations[animation]
  local currentFrame = frame or 1
  local frameTime = 0

  local isAnimating = true


  ----------------------------------------------
  -- attributes
  ----------------------------------------------




  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if isAnimating then
      local frames = animation.frames
      local interval = animation.interval

      -- frame timer
      frameTime = frameTime + dt;
      if frameTime >= interval then
          frameTime = frameTime - interval;
          currentFrame = currentFrame + 1
          if currentFrame > #frames then currentFrame = 1 end
      end

      node.sprite = frames[currentFrame]
    end
  end

  function self:start(atFrame)
    if not isAnimating then
      local atFrame = atFrame or currentFrame
      local frames = animation.frames

      -- make sure that the given frame is in range
      if atFrame > #frames then
        currentFrame = #frames
      else
        currentFrame = atFrame
      end

      isAnimating = true
    end
  end

  function self:pause()
    if isAnimating then
      isAnimating = false
    end
  end

  function self:stop()
    if isAnimating then
      currentFrame = 1
      isAnimating = false
    end
  end


  ----------------------------------------------
  return self
end

return animator
