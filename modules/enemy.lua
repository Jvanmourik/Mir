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
  startX = self.x
  startY = self.y

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    if(self.agent:area(250, self.target)) then
      self.agent:charge(self.target)
    end

  --self.agent:patrolling(startX , 500, startY, startY)

  --self.agent:follow(self.target)

  --[[if(self.agent:area(200, self.target) == false) then
    self.agent:patrolling(startX, 250, startY, startY)
  elseif(self.agent:insideScreen(self)) then
    self.agent:follow(self.target)
  end]]
  end


  ----------------------------------------------
  return self
end

return enemy
