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

  -- load modules
  local Scene = require "modules/scene"
  local Character = require "modules/character"

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  p = Character(400, 300)
  scene:addChild(p)

  c = Character(0, 14)
  p:addChild(c)

  gc = Character(0, 14)
  c:addChild(gc)

  ggc = Character(0, 14)
  gc:addChild(ggc)

  gggc = Character(0, 14)
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

  -- draw scene
  scene:draw()
end
