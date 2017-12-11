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

<<<<<<< HEAD
    -- set amount of times to play, 0 = infinite loop
    if amount == 0 then isLooping = true else isLooping = false end --TODO: refactor
    iterationCount = amount or 1

    -- set callback
    _callback = callback
=======
     -- set amount of times to play, 0 = infinite loop
    isLooping = (amount == 0) and true or false
    altp = amount or 1
>>>>>>> fb0314c6d23e2fe9eb803c154da122865daf94b1

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
    -- reset current frame
    currentFrame = 1

    -- update the sprite
    node.sprite = animation.frames[currentFrame]

    isAnimating = false
  end


  ----------------------------------------------
  return self
end

return animator
