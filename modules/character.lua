local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)
  local assets = require "templates/assets"
  local sprite = assets.kramer.graphics.walk.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()
  local atlas = lg.newImage("assets/images/atlas.png")
  
  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, sprite, layer, atlas)

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
    if(love.keyboard.isDown("a")) then
      self.x = self.x - 5
    end
    if(love.keyboard.isDown("d")) then
      self.x = self.x + 5
    end
    if(love.keyboard.isDown("w")) then
      self.y = self.y - 5
    end
    if(love.keyboard.isDown("s")) then
      self.y = self.y + 5
    end
  end


  ----------------------------------------------
  return self
end

return character
