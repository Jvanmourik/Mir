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

  -- load modules
  local Scene = require "modules/scene"
  local Character = require "modules/character"

  -- create scene
  scene = Scene()

  -- populate scene
  p = Character(10, 130)
  scene:addChild(p)

  c = Character(16, 14)
  p:addChild(c)
end

function love.update(dt)
  -- update scene
  scene:update(dt)
end

function love.draw()
  -- print strings
  lg.print("#scene.children = " .. #p.children, 10, 10)
  lg.print("#scene:getAllChildren() = " .. #scene:getAllChildren(), 10, 30)
  lg.print("#p.children = " .. #p.children, 10, 50)
  lg.print("#c.children = " .. #c.children, 10, 70)
  lg.print("c:getWX() = " .. c:getWX(), 10, 90)
  lg.print("c.x = " .. c.x, 10, 110)

  -- draw scene
  scene:draw()
end
