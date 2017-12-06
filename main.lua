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
	local Enemy = require "modules/enemy"

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  local w, h = lg.getDimensions()

  local c = Character(w * 0.5, h * 0.5)
  c.name = "character"
  scene.rootNode:addChild(c)

	local e = Enemy(100, 100)
	scene.rootNode:addChild(e)

	local f = Enemy(300, 300)
	scene.rootNode:addChild(f)

end

function love.update(dt)
  -- update scene
  scene:update(dt)
end

function love.draw()
  -- draw scene
  scene:draw()
end
