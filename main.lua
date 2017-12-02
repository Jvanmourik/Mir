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
  lp = love.physics

  -- set background color
  lg.setBackgroundColor(222, 222, 222)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"
  debugWorldDraw = require("lib/debugWorldDraw")

  -- load modules
  local Scene = require "modules/scene"
  local Character = require "modules/character"

  -- create a world for physic bodies to exist in
  world = lp.newWorld()

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  c = Character(100, 100)
  c.anchorX, c.anchorY = 1, 1
  scene.rootNode:addChild(c)
end

function love.update(dt)
  -- update scene
  scene:update(dt)
  world:update(dt)
end

function love.draw()
  -- draw scene
  scene:draw()

  local w, h = lg.getDimensions()
  debugWorldDraw(world,0,0,w,h)
end
