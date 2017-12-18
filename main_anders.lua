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

  -- set background color
  lg.setBackgroundColor(222, 222, 222)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"

  -- load templates
  --assets = require "templates/assets"
  graphics = require "templates/graphics"
  animations = require "templates/animations"

  -- load modules
  local Scene = require "modules/scene"
	local Tilemap = require "modules/tilemap"
  local Character = require "modules/character"
	require "modules/map-functions"
	loadMap()
  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  local t = Tilemap()
  scene.rootNode:addChild(t)

  local c = Character(100, 100)
  scene.rootNode:addChild(c)
end

function love.update(dt)
  -- update scene
  scene:update(dt)
end

function love.draw()
  -- draw scene
  drawMap()
	scene:draw()
end
