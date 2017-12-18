local sti = require "lib/sti"
local map
local world
local tx, ty

function love.load()
	-- declare shorthand framework names
	lg = love.graphics
	li = love.image
	la = love.audio
	lm = love.mouse
	lk = love.keyboard
	lt = love.timer
	le = love.event
	ls = love.system
	lw = love.window
	lf = love.filesystem

	-- Load map
	map = sti("tiled/tilesets/level.lua", { "box2d" })

	    -- Create new dynamic data layer called "Sprites" as the 8th layer
	    local layer = map:addCustomLayer("Sprites", 8)

	    -- Get player spawn object
	    local player
	    for k, object in pairs(map.objects) do
	        if object.name == "playerSpawn" then
	            player = object
	            break
	        end
	    end

	    -- Create player object
	    local sprite = love.graphics.newImage("assets/images/atlas.png")
	    layer.player = {
	        sprite = sprite,
	        x      = player.x,
	        y      = player.y,
	        ox     = sprite:getWidth() / 2,
	        oy     = sprite:getHeight() / 1.35
	    }

	    -- Draw player
	    layer.draw = function(self)
	        love.graphics.draw(
	            self.player.sprite,
	            math.floor(self.player.x),
	            math.floor(self.player.y),
	            0,
	            1,
	            1,
	            self.player.ox,
	            self.player.oy
	        )

	        -- Temporarily draw a point at our location so we know
	        -- that our sprite is offset properly
	        love.graphics.setPointSize(5)
	        love.graphics.points(math.floor(self.player.x), math.floor(self.player.y))
	    end

	-- Prepare translations
	tx, ty = 0, 0

	-- Prepare physics world
	--love.physics.setMeter(32)
	--world = love.physics.newWorld(0, 0)
	--map:box2d_init(world)
	-- Remove unneeded object layer
	--map:removeLayer("objectlaag")
end

function love.update(dt)
	--world:update(dt)
	--map:update(dt)

	--Move map
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
