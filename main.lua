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

	-- set window to fullscreen in desktop mode
	--lw.setFullscreen(true, "desktop")

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
  Player = require "modules/player"
  Enemy = require "modules/enemy"
  Item = require "modules/item"

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

	for i=1,20 do
		local zwaard = Item(1, 100 + i * 10, 100 + i * 10)
		scene.rootNode:addChild(zwaard)
	end

	-- iterate through all spawn locations
	for _, location in pairs(scene.rootNode:getChildrenByType("location")) do
		-- set amount to spawn
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
				c = Player(math.floor(x + 0.5), math.floor(y + 0.5))
				scene.rootNode:addChild(c)

				-- create camera
				camera = Camera(c.x, c.y)
				--camera:zoomTo(1.5)
			elseif location.properties.spawntype == "enemy" then
				-- create enemy
				local e = Enemy(x, y)
				scene.rootNode:addChild(e)
			end
		end
	end

	-- iterate through all paths
	for _, path in pairs(scene.rootNode:getChildrenByType("path")) do
		local x = path.vertices[1].x
		local y = path.vertices[1].y

		local e = Enemy(x, y)
		e.agent:followPath(path.vertices, true)
		scene.rootNode:addChild(e)
	end
end

function love.update(dt)
  -- update scene
  scene:update(dt)

	local dx,dy = c.x - camera.x, c.y - camera.y
	camera:move(math.floor(dx/10 + 0.5), math.floor(dy/10 + 0.5))

	if lk.isDown("r") then
		for _, node in pairs(scene.rootNode:getChildren()) do
			if node.name == "player" then
				local x, y = 120, 1200
				node.x = x
				node.y = y
				node.collider.shape:moveTo(x, y)
				node:revive()
			end
		end
	end
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
			if node.collider.isColliding then
				lg.setColor(255, 0, 255, 100)
				node.collider.shape:draw('fill')
				lg.setColor(255, 0, 255, 255)
				node.collider.shape:draw('line')
				lg.setColor(255, 255, 255)
			elseif node.collider.isSensor then
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
		c = Player(400, 300, gamepad)
		scene.rootNode:addChild(c)
	end
end
