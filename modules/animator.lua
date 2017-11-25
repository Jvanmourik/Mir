local function animator(node, animations, animationName, startingFrame)
  local self = {}

  local animation = animations[animationName]
  local currentFrame = startingFrame or 1
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

  function self:start(startingFrame)
    if not isAnimating then
      local startingFrame = startingFrame or currentFrame
      local frames = animation.frames

      -- make sure that the given frame is in range
      if startingFrame > #frames then
        currentFrame = #frames
      else
        currentFrame = startingFrame
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

  function self:setAnimation(animationName)
    animation = animations[animationName]
  end


  ----------------------------------------------
  return self
end

return animator
