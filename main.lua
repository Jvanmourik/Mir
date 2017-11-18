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
  local w, h, r, ax, ay = 16, 14, 0, 0.5, 0.5
  p = Character(400, 300, w, h, 0, ax, ay)
  scene:addChild(p)

  c = Character(0, 14, w, h, 0, ax, ay)
  p:addChild(c)

  gc = Character(0, 14, w, h, 0, ax, ay)
  c:addChild(gc)

  ggc = Character(0, 14, w, h, 0, ax, ay)
  gc:addChild(ggc)

  gggc = Character(0, 14, 2*w, 2*h, 0, ax, ay)
  ggc:addChild(gggc)
end

function love.update(dt)
  -- update scene
  scene:update(dt)
end

function love.draw()
  -- print strings
  lg.print("#scene.children = " .. #p.children, 10, 10)
  lg.print("#scene:getAllChildren() = " .. #scene:getAllChildren(), 10, 30)
  lg.print("p.rotation = " .. p.rotation, 10, 50)
  lg.print("gc.rotation = " .. gc.rotation, 10, 70)
  lg.print("p:getWorldRotation() = " .. p:getWorldRotation(), 10, 90)
  lg.print("gc:getWorldRotation() = " .. gc:getWorldRotation(), 10, 110)
  lg.print("vector.length(p.x, p.y) = " .. vector.length(p.x, p.y), 10, 130)
  local x, y = vector.normalize(p.x, p.y)
  lg.print("vector.normalize(p.x, p.y) = (" .. x .. ", " .. y .. ")", 10, 150)

  -- draw scene
  scene:draw()

  -- draw red dot
  lg.setColor(255, 0, 0, 255)
  lg.setPointSize(2)
  lg.points(400, 300)
  lg.setColor(255, 255, 255, 255)
end
