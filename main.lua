function love.load()
  -- declare shorthand framework names
	lg = love.graphics
	li = love.image
	la = love.audio
	lm = love.mouse
	lj = love.joystick
	lk = love.keyboard
	lt = love.timer
	le = love.event
	ls = love.system
	lw = love.window
	lf = love.filesystem
  lp = love.physics

  -- set background color
  lg.setBackgroundColor(255, 255, 255)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"
  debugWorldDraw = require "lib/debugWorldDraw"

  -- load modules
	local Input = require "modules/input"
  local Scene = require "modules/scene"
  local Character = require "modules/character"
  local Enemy = require "modules/enemy"

	-- load controller mappings
	local mappings = require 'mappings'
	lj.loadGamepadMappings(mappings)

	-- create input handler
	input = Input()

  -- create a world for physic bodies to exist in
  world = lp.newWorld()
  world:setCallbacks(beginContact, endContact)

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  c = Character(400, 300)
  scene.rootNode:addChild(c)

  e = Enemy(200, 100)
  scene.rootNode:addChild(e)

	--[[local joysticks = love.joystick.getJoysticks()
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'a', 'button', 2, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'b', 'button', 3, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'x', 'button', 1, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'y', 'button', 4, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'back', 'button', 9, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'guide', 'button', 13, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'start', 'button', 10, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'leftstick', 'button', 11, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'rightstick', 'button', 12, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'leftshoulder', 'button', 5, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'rightshoulder', 'button', 6, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'dpup', 'hat', 1, 'u')
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'dpdown', 'hat', 1, 'd')
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'dpleft', 'hat', 1, 'l')
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'dpright', 'hat', 1, 'r')
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'leftx', 'axis', 1, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'lefty', 'axis', 2, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'rightx', 'axis', 3, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'righty', 'axis', 6, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'triggerleft', 'axis', 4, nil)
	love.joystick.setGamepadMapping(joysticks[1]:getGUID(), 'triggerright', 'axis', 5, nil)]]
end

function love.update(dt)
  -- update scene
  scene:update(dt)

	-- update physic bodies
  world:update(dt)
end

function love.draw()
  -- draw scene
  scene:draw()

  local w, h = lg.getDimensions()
  --debugWorldDraw(world,0,0,w,h)
end

--[[function love.joystickpressed(joystick,button)
	print(button)
end]]

--[[function love.joystickhat(joystick, hat, direction)
		print(hat)
		print(direction)
end]]

--[[function love.joystickaxis(joystick, axis, value)
	print(axis)
end]]

-- gets called when two physic objects start colliding
function beginContact(f1, f2, contact)
  for _, node in pairs(scene.rootNode:getAllChildren()) do
    if node.beginContact and node.collider then
      if node.collider.fixture == f1 then
        node:beginContact(f2, contact)
      elseif node.collider.fixture == f2 then
        node:beginContact(f1, contact)
      end
    end
  end
end

-- gets called when two physic objects stop colliding
function endContact(f1, f2, contact)
  for _, node in pairs(scene.rootNode:getAllChildren()) do
    if node.endContact and node.collider then
      if node.collider.fixture == f1 then
        node:endContact(f2, contact)
      elseif node.collider.fixture == f2 then
        node:endContact(f1, contact)
      end
    end
  end
end
