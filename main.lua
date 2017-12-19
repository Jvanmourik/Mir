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

  --set scale
  scale = love.window.getPixelScale( )
  love.graphics.scale(scale, scale)
  
  -- set background color
  lg.setBackgroundColor(222, 222, 222)

  -- load extensions
  require "extensions"

  -- load libraries
  vector = require "lib/vector"
  suit = require "lib/suit"

  -- load modules
  local Scene = require "modules/scene"
  local Character = require "modules/character"
  local Audio = require "modules/audio"
  local Enemy = require "modules/enemy"
  local Gui = require "modules/gui"
  
  -- create gui
  gui = Gui()

  -- create a world for physic bodies to exist in
  world = lp.newWorld()
  world:setCallbacks(beginContact, endContact)

  -- create scene
  scene = Scene(0, 0)

  -- populate scene
  c = Character(100, 100)
  c.anchorX, c.anchorY = 0.5, 0.5
  scene.rootNode:addChild(c)

  e = Enemy(200, 100)
  e.anchorX, e.anchorY = 0.5, 0.5
  scene.rootNode:addChild(e)
end

function love.update(dt)
  if gameState == 0 then
    -- update GUI
    gui:update(dt)
  
  else
    -- update scene
    scene:update(dt)

    -- update world
    world:update(dt)
  end
end

function love.draw()
  if gameState == 0 then
    -- draw GUI
    suit.draw()
  else
    -- draw scene
    scene:draw()
  end
end

-- gets called when two physic objects start colliding
function beginContact(f1, f2, contact)
  for _, node in pairs(scene.rootNode:getAllChildren()) do
    if node.collider.fixture == f1 then
      if node.beginContact then
        node:beginContact(f2, contact)
      end
      break
    end
  end
end

-- gets called when two physic objects stop colliding
function endContact(f1, f2, contact)
  for _, node in pairs(scene.rootNode:getAllChildren()) do
    if node.collider.fixture == f1 then
      if node.endContact then
        node:endContact(f2, contact)
      end
      break
    end
  end
end
