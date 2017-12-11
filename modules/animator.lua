local function animator(node, animations)
  local self = {}

  local animation
  local currentFrame = 1
  local frameTime = 0

  local isAnimating = false
  local isLooping = false
  local iterationCount = 0
  local _callback

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if isAnimating then
      local frames = animation.frames
      local interval = animation.interval

      -- frame timer
      frameTime = frameTime + dt
      if frameTime >= interval then
        frameTime = frameTime - interval;
        currentFrame = currentFrame + 1

        -- if sequence ends
        if currentFrame > #frames then
          if isLooping then
            currentFrame = 1
          elseif iterationCount > 1 then
            iterationCount = iterationCount - 1
            currentFrame = 1
          else
            self:stop()
            if _callback then _callback() end
            return
          end
        end
      end

      -- update the sprite
      node.spriteRenderer:setSprite(animation, currentFrame)
    end
  end

  -- play animation
  function self:play(animationName, amount, callback)
    -- reset current frame
    currentFrame = 1

    -- set animation
    animation = animations[animationName]

    -- set amount of times to play, 0 = infinite loop
    isLooping = (amount == 0) and true or false
    iterationCount = amount or 1

    -- set callback
    _callback = callback

    -- update the sprite
    node.spriteRenderer:setSprite(animation, currentFrame)

    isAnimating = true
  end

  -- pause animation
  function self:pause()
    isAnimating = false
  end

  -- stop animation
  function self:stop()
    -- reset current frame
    currentFrame = 1

    -- update the sprite
    node.spriteRenderer:setSprite(animation, currentFrame)

    isAnimating = false
  end

  function self:isPlaying()
    return isAnimating
  end


  ----------------------------------------------
  return self
end

return animator
