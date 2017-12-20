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
	Input = require "modules/input"
  Scene = require "modules/scene"
  Tilemap = require "modules/tilemap"
  Character = require "modules/character"
  Enemy = require "modules/enemy"

	-- load controller mappings
	local mappings = require "mappings"
	lj.loadGamepadMappings(mappings)

	-- create input handler
	input = Input()

  -- create a world for physic bodies to exist in
  world = lp.newWorld()
  world:setCallbacks(beginContact, endContact)

  -- create scene
  scene = Scene(0, 0)

	map = Tilemap("level")
	scene.rootNode:addChild(map)

  -- populate scene
	local c = Character(400, 300, gamepad)
	scene.rootNode:addChild(c)
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

  --local w, h = lg.getDimensions()
  --debugWorldDraw(world,0,0,w,h)
end

function love.joystickadded(joystick)
	-- add player character when a controller gets connected
	if joystick:isGamepad() then
		local gamepad = input:getGamepad(joystick)
		local c = Character(400, 300, gamepad)
		scene.rootNode:addChild(c)
	end
end

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
