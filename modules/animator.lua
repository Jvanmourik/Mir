local function animator(node, animations, animationName)
  local self = {}

  local animation = animations[animationName]
  local currentFrame = 1
  local frameTime = 0

  local isAnimating = false
  local isLooping = false
  local altp = 0 -- Amount of times Left To Play animation

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
          elseif altp > 1 then
            altp = altp - 1
            currentFrame = 1
          else
            self:stop()
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
    if amount == 0 then isLooping = true else isLooping = false end --TODO: refactor
    altp = amount or 1

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
