local sti = require "lib/sti"
local map
local world
local tx, ty

function love.load()
	-- Load map
	map = sti("tiled/tilesets/level.lua", { "box2d" })

	-- Prepare translations
	tx, ty = 0, 0

	-- Prepare physics world
	--love.physics.setMeter(32)
	--world = love.physics.newWorld(0, 0)
	--map:box2d_init(world)
end

function love.update(dt)
	--world:update(dt)
	--map:update(dt)

	-- Move map
	local kd = love.keyboard.isDown
	local l  = kd("left")  or kd("a")
	local r  = kd("right") or kd("d")
	local u  = kd("up")    or kd("w")
	local d  = kd("down")  or kd("s")

	tx = l and tx - 128 * dt or tx
	tx = r and tx + 128 * dt or tx
	ty = u and ty - 128 * dt or ty
	ty = d and ty + 128 * dt or ty
end

function love.draw()
	-- Draw map
	map:draw(-tx, -ty)
end
