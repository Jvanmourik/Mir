local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Character = require "modules/character"

local function redenemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)
  local assets = require "templates/assets"
  local sprite = assets.redenemysprite.graphics.shrink.frames[1]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()
  local atlas = lg.newImage("assets/images/redenemy.png")

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, sprite, layer, atlas)

  -- animator component to animate the sprite
  self.animator = Animator(self, assets.redenemysprite.animations, "shrink")


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end


  ----------------------------------------------
  return self
end

return redenemy
