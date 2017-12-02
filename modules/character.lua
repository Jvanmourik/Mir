local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Collider = require "modules/collider"

local function character(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)

  local assets = require "templates/assets"
  local sprite = assets.kramer.graphics.walk.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, sprite, layer)

  -- animator component to animate the sprite
  self.animator = Animator(self, assets.kramer.animations, "walk")

  -- collider component to collide with other collision objects
  self.collider = Collider(self)


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if(lk.isDown("a")) then
      self.x = self.x - 100 * dt
    end
    if(lk.isDown("d")) then
      self.x = self.x + 100 * dt
    end
    if(lk.isDown("w")) then
      self.y = self.y - 100 * dt
    end
    if(lk.isDown("s")) then
      self.y = self.y + 100 * dt
    end
  end


  ----------------------------------------------
  return self
end

return character
