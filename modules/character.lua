local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"
  local sprite = assets.kramer.graphics.walk.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, sprite, layer)

  -- animator component to animate the sprite
  self.animator = Animator(self, assets.kramer.animations, "walk")


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    touch = {x=self.x,y=self.y} 
    for i, id in ipairs(love.touch.getTouches()) do
      touch.x, touch.y = love.touch.getPosition(id)
    end
    if(love.keyboard.isDown("a") or touch.x < self.x) then
      self.x = self.x - 100 * dt
    end
    if(love.keyboard.isDown("d") or touch.x > self.x) then
      self.x = self.x + 100 * dt
    end
    if(love.keyboard.isDown("w") or touch.y < self.y) then
      self.y = self.y - 100 * dt
    end
    if(love.keyboard.isDown("s") or touch.y > self.y) then
      self.y = self.y + 100 * dt
    end
  end



  ----------------------------------------------
  return self
end

return character
