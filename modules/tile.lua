local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"

local function tile(x, y, tileset, tile, layer)
  local self = Node(x, y)

  local atlas = lg.newImage("assets/images/countrysideTEST.png")
  local sprite = tileset[tile]
  local _, _, spriteWidth, spriteHeight = sprite:getViewport()


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self.spriteRenderer = SpriteRenderer(self, atlas, sprite, layer)


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

return tile
