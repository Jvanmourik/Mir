local function animator(node, animations, animationName)
  local self = {}

  local animation = animations[animationName]
  local currentFrame = 1
  local frameTime = 0

  local isAnimating = false


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

      print(currentFrame)
      -- update the sprite
      node.spriteRenderer:setSprite(animation, currentFrame)

    end
  end

  -- play animation
  function self:play(animationName, amount, callback)
    animation = animations[animationName]
    print("play")
    -- update the sprite
    node.sprite = animation.frames[currentFrame]

    isAnimating = true
  end

  -- pause animation
  function self:pause()
    isAnimating = false
  end

  -- stop animation
  function self:stop()
    local frames = animation.frames

    -- reset current frame
    currentFrame = 1

    -- update the sprite
    node.sprite = frames[currentFrame]

    isAnimating = false
  end


  ----------------------------------------------
  return self
end

return animator
