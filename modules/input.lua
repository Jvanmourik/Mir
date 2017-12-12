local function input(...)
  local self = {}

  local prevState = {}
  local state = {}

  -- register callbacks
  local callbacks = {'keypressed', 'keyreleased', 'mousepressed', 'mousereleased', 'update'}
  local _love = {}
  for _, c in pairs(callbacks) do
    _love[c] = love[c] or function() end
    love[c] = function(...)
      _love[c](...)
      self[c](self, ...)
    end
  end

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- if key/button is pressed down this frame
  function self:isPressed(key)
    return state[key] and not prevState[key] and true or false
  end

  -- if key/button is down
  function self:isDown(key)
    return state[key] and true or false
  end

  function self:update(dt)
    prevState = table.copy(state)
  end

  function self:keypressed(key, scancode, isrepeat)
    state[key] = true
  end

  function self:keyreleased(key, scancode)
    state[key] = false
  end

  function self:mousepressed(x, y, button, istouch)
    state[button] = true
  end

  function self:mousereleased(x, y, button, istouch)
    state[button] = false
  end


  ----------------------------------------------
  return self
end

return input
