local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Agent = require "modules/agent"

local function enemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
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

  -- agent component to add intelligent behaviour
  self.agent = Agent(self)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or spriteWidth
  self.height = h or spriteHeight

  self.target = scene.rootNode:getChild("character")


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    self.agent:follow(self.target)
  end


  ----------------------------------------------
  return self
end

return enemy
