local function input(...)
  local self = {}

  local prevState = {}
  local state = {}

  -- register callbacks
  local callbacks = {'keypressed', 'keyreleased',
  'mousepressed', 'mousereleased',
  'gamepadpressed', 'gamepadreleased', 'gamepadaxis',
  'joystickadded', 'joystickremoved'}
  local _love = {}
  for _, c in pairs(callbacks) do
    _love[c] = love[c] or function() end
    love[c] = function(...)
      self[c](self, ...)
      _love[c](...)
    end
  end

  _love.update = love.update or function() end
  love.update = function(...)
    _love.update(...)
    self.update(self, ...)
  end

  -- gamepad object to keep track of individual gamepad states
  local gamepad = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  -- table to keep track of and access connected gamepads
  self.gamepads = {}


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- if key/button is pressed down this frame
  function self:isPressed(key)
    return state[key] and not prevState[key] and true or false
  end

  -- if key/button is down
  function self:isDown(key)
    return state[key]
  end

  -- if gamepad button is pressed down this frame
  function gamepad:isPressed(button)
    return self.state[button] and not self.prevState[button] and true or false
  end

  -- if gamepad button is down
  function gamepad:isDown(button)
    return self.state[button]
  end

  -- get direction of an axis
  function gamepad:getAxis(axis)
    return self.state[axis] or 0
  end

  -- add new gamepad to the table self.gamepads
  function self:addGamepad(joystick)
    local gamepad = table.copy(gamepad)
    gamepad.id, _ = joystick:getID()
    gamepad.joystick = joystick
    gamepad.prevState = {}
    gamepad.state = {}
    self.gamepads[#self.gamepads + 1] = gamepad
  end

  -- remove an already existing gamepad from the table self.gamepads
  function self:removeGamepad(joystick)
    for i = 1, #self.gamepads, 1 do
      if self.gamepads[i].joystick == joystick then
        self.gamepads[i] = nil
      end
    end
  end

  -- get gamepad object by joystick
  function self:getGamepad(joystick)
    local id, _ = joystick:getID()
    for _, gamepad in pairs(self.gamepads) do
      if id == gamepad.id then
        return gamepad
      end
    end
  end

  function self:update(dt)
    prevState = table.copy(state)
    for _, gamepad in pairs(self.gamepads) do
      gamepad.prevState = table.copy(gamepad.state)
    end
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

  function self:gamepadpressed(joystick, button)
    self:getGamepad(joystick).state[button] = true
  end

  function self:gamepadreleased(joystick, button)
    self:getGamepad(joystick).state[button] = false
  end

  function self:gamepadaxis(joystick, axis, value)
    self:getGamepad(joystick).state[axis] = value
  end

  function self:joystickadded(joystick)
    self:addGamepad(joystick)
  end

  function self:joystickremoved(joystick)
    self:removeGamepad(joystick)
  end


  ----------------------------------------------
  return self
end

return input
