local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"
local Animator = require "modules/animator"
local Agent = require "modules/agent"

local function enemy(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY, layer)
  local self = Node(x, y, w, h, r, scaleX, scaleY, anchorX, anchorY)
  local assets = require "templates/assets"
  local sprite = assets.redenemysprite.graphics.shrink.frames[1]
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

  local _, _, spriteWidth, spriteHeight = sprite:getViewport()
  self.width = w or spriteWidth
  self.height = h or spriteHeight
  self.speed = 2
  self.target = scene.rootNode:getChild("character")
  self.traveling = false


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
  if(self.traveling == false) then
    dirX, dirY = self.agent:direction(self.target)
  elseif(self.agent:insideScreen(self)) then
      self.agent:follow(self.target)
  else
    self.traveling = false
  end
    if(self.agent:area(250, self.target) and self.traveling == false) then
    self.traveling = true
  end
  end


  ----------------------------------------------
  return self
end

return enemy
