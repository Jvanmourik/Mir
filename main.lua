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

	-- set random seed so initial math.random() will always be different
	math.randomseed(lt.getTime())

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

  -- create scene
  scene = Scene(0, 0)

	-- create tilemap
	map = Tilemap("overworld")
	scene.rootNode:addChild(map)

	-- iterate through all spawn locations
	for _, location in pairs(scene.rootNode:getChildrenByType("location")) do
		local spawncount = location.properties.spawncount or 1
		for i = 1, spawncount do
			local x = location.x
			local y = location.y

			-- set spawn position
			if location.properties.spawnposition == "center" then
				x = location.x + location.width * 0.5
				y = location.y + location.height * 0.5
			elseif location.properties.spawnposition == "random" then
				x = location.x + location.width * math.random()
				y = location.y + location.height * math.random()
			end

			if location.properties.spawntype == "player" then
				-- create player
				c = Character(math.floor(x + 0.5), math.floor(y + 0.5))
				scene.rootNode:addChild(c)

				-- create camera
				camera = Camera(c.x, c.y)
			elseif location.properties.spawntype == "enemy" then
				-- create enemy
				local e = Enemy(x, y)
				scene.rootNode:addChild(e)
			end
		end
	end

	-- iterate through all spawn locations
	for _, pathNode in pairs(scene.rootNode:getChildrenByType("path")) do
		local x = pathNode.x + pathNode.polyline[1].x
		local y = pathNode.y + pathNode.polyline[1].y

		local e = Enemy(x, y)
		e.agent:followPath(pathNode, true)
		scene.rootNode:addChild(e)
	end
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
	for _, node in pairs(scene.rootNode:getChildren()) do
		if node.active and node.collider and node.collider.active then
			if node.collider.isSensor then
				lg.setColor(255, 255, 0, 100)
				node.collider.shape:draw('fill')
				lg.setColor(255, 255, 0, 255)
				node.collider.shape:draw('line')
				lg.setColor(255, 255, 255)
			else
				lg.setColor(0, 255, 255, 100)
				node.collider.shape:draw('fill')
				lg.setColor(0, 255, 255, 255)
				node.collider.shape:draw('line')
				lg.setColor(255, 255, 255)
			end
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
