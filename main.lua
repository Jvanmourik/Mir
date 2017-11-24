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

  -- load modules
  local Scene = require "modules/scene"
  local Character = require "modules/character"

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  c1 = Character(0, 0)
  c1.graphic.layer = 1
  scene.rootNode:addChild(c1)

  c2 = Character(20, 0)
  scene.rootNode:addChild(c2)
end

function love.update(dt)
  -- update scene
  scene:update(dt)
end

function love.draw()
  -- draw scene
  scene:draw()
end
