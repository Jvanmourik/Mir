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
  lg.setBackgroundColor(19, 19, 19)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"
	HC = require "lib/HC"
	Camera = require "lib/camera"

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

  -- create scenewds
  scene = Scene(0, 0)
	scene.debug = true

	map = Tilemap("overworld")
	scene.rootNode:addChild(map)

  -- populate scene
	c = Character(600, 500, gamepad)
	scene.rootNode:addChild(c)

	local e = Enemy(200, 180)
	scene.rootNode:addChild(e)

	camera = Camera(c.x, c.y)
end

function love.update(dt)
  -- update scene
  scene:update(dt)

	local dx,dy = c.x - camera.x, c.y - camera.y
	camera:move(math.floor(dx/10 + 0.5), math.floor(dy/10 + 0.5))
end

function love.draw()
  -- draw scene
	camera:attach()
  scene:draw()
	drawCollisionShapes()
	camera:detach()


end

function drawCollisionShapes()
	-- draw all collision shapes
	for _, node in pairs(scene.rootNode:getAllChildren()) do
		if node.active and node.collider and node.collider.active then
			lg.setColor(0, 255, 255, 100)
			node.collider.shape:draw('fill')
			lg.setColor(0, 255, 255, 255)
			node.collider.shape:draw('line')
			lg.setColor(255, 255, 255)
		end
	end
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
