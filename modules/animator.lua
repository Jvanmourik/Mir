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

      -- update the sprite
      node.sprite = frames[currentFrame]
    end
  end

  -- start animating
  function self:start(startingFrame)
    local startingFrame = startingFrame or currentFrame
    local frames = animation.frames

    -- make sure that the given frame is in range
    if startingFrame > #frames then
      currentFrame = #frames
    else
      currentFrame = startingFrame
    end

    -- update the sprite
    node.sprite = frames[currentFrame]

    isAnimating = true
  end

  -- pause animating
  function self:pause()
    isAnimating = false
  end

  -- stop animating
  function self:stop()
    local frames = animation.frames

    -- reset current frame
    currentFrame = 1

    -- update the sprite
    node.sprite = frames[currentFrame]

    isAnimating = false
  end

  function self:setAnimation(animationName)
    animation = animations[animationName]
  end


  ----------------------------------------------
  return self
end

return animator
