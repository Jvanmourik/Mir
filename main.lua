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

  --set scale
  scale = love.window.getPixelScale( )
  love.graphics.scale(scale, scale)
	-- set window to fullscreen in desktop mode
	lw.setFullscreen(false, "desktop")

	-- set random seed so initial math.random() will always be different
	math.randomseed(lt.getTime())

	-- set window to fullscreen in desktop mode
	lw.setFullscreen(true, "desktop")

  -- set background color
  lg.setBackgroundColor(19, 19, 19)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"
  HC = require "lib/HC"
  Camera = require "lib/camera"
  suit = require "lib/suit"


  -- load modules
	Input = require "modules/input"
  Scene = require "modules/scene"
  Tilemap = require "modules/tilemap"
  Player = require "modules/player"
  Enemy = require "modules/enemy"
  Audio = require "modules/audio"
  Gui = require "modules/gui"
  Score = require "modules/score"
  Lifes = require "modules/lifes"
  Item = require "modules/item"
	Boss = require "modules/boss"
	Lives = require "modules/lives"

	-- load controller mappings
	local mappings = require "mappings"
	lj.loadGamepadMappings(mappings)

	-- create input handler
	input = Input()

 -- create gui
 gui = Gui()

 -- create score
 score = Score()

 -- create lifes
 lifes = Lifes()

 -- create scene
 scene = Scene(0, 0)

	local item = Item(3, 150, 200)
	scene.rootNode:addChild(item)

	-- create tilemap
	map = Tilemap("overworld")
	scene.rootNode:addChild(map)

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
				spawnPoint = location

				-- create camera
				camera = Camera(c.x, c.y)
				--camera:zoomTo(1.5)
			elseif location.properties.spawntype == "enemy" then
				-- create enemy
				local e = Enemy(x, y)
				scene.rootNode:addChild(e)
			elseif location.properties.spawntype == "boss" then
				-- create boss
				local b = Boss(x, y)
				scene.rootNode:addChild(b)
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
	lives = Lives(10, 10)
	scene.rootNode:addChild(lives)
	deathTimer = 0
	deathBoolean = false
end

function love.update(dt)
  if gameState == 0 or gameState == 2 then
    -- update GUI
    gui:update(dt)
  else
		-- update scene
	  scene:update(dt)

		local players = scene.rootNode:getChildrenByName("player")

		local averageX, averageY = 0, 0
		local activePlayers = {}
		for _, player in pairs(players) do
			if player.active then
				activePlayers[#activePlayers + 1] = player
				averageX = averageX + player.x
				averageY = averageY + player.y
			end
		end
		if #activePlayers > 0 then
			averageX = averageX / #activePlayers
			nextX = averageX
			averageY = averageY / #activePlayers
			nextY = averageY
		end

		if #activePlayers == 0 then
			local dx, dy = nextX - camera.x, nextY - camera.y
			camera:move(math.floor(dx/10 + 0.5), math.floor(dy/10 + 0.5))
		end


		if #activePlayers > 0 then
			local dx, dy = averageX - camera.x, averageY - camera.y
			camera:move(math.floor(dx/10 + 0.5), math.floor(dy/10 + 0.5))
		end


		if deathBoolean then
			deathTimer = deathTimer - 1000 * dt
		end

		if deathBoolean and deathTimer <= 0 then
			deathBoolean = false
			for _, player in pairs(players) do
				if not player.active then
					player.revive(player)
				end
			end
		end

		if lk.isDown("r") then
			for _, player in pairs(players) do
				player.x = spawnPoint.x
				player.y = spawnPoint.y
				player.collider.shape:moveTo(spawnPoint.x, spawnPoint.y)
				player:revive()
			end
		end
		if input:isPressed("escape") then
			gameState = 2
		end
	end
end

function love.draw()
  if gameState == 0 or gameState == 2 then
    -- draw GUI
    suit.draw()
  else
		-- draw scene
		camera:attach()
		scene:draw()
		--drawCollisionShapes()
		camera:detach()
    score:draw()
    lifes:draw()
  end
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
		local player = Player(spawnPoint.x, spawnPoint.y, gamepad)
		scene.rootNode:addChild(player)

		-- add player to players table
		players[joystick] = player
	end
end

function love.joystickremoved(joystick)
	players[joystick]:kill()
	players[joystick] = nil
end

--[[function love.joystickremoved(joystick)
	if joystick:isGamepad() then
		print("hi")
		local gamepad = input:getGamepad(joystick)
		for _, player in pairs(scene.rootNode:getChildren()) do
			print(gamepad.id)
			print(player.gamepad.id)
			if player.active and gamepad.id == player.gamepad.id then
				player.active = false
			end
		end
	end
end]]
