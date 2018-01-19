local function enemy(x, y)
  local self = Character(x, y)
  local base = {}; base.update = self.update or function() end

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  ----------------------------------------------
  -- components
  ----------------------------------------------

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)

  end

  return self
end

return enemy
