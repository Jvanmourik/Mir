local Node = require "modules/node"
local SpriteRenderer = require "modules/spriteRenderer"

local quad = love.graphics.newQuad

local function tilemap(name, x, y)
  local self = Node(x, y)

  local exportedTable = require ("assets/maps/" .. name)

  -- stores all possible tilesets
  local tiles = {}

  -- populate tiles table
  local i = 1
  for _, ts in pairs(exportedTable.tilesets) do
    local tw, th = ts.tilewidth, ts.tileheight
    local iw, ih = ts.imagewidth, ts.imageheight
    local tc = ts.tilecount

    -- add quads to tile table
    for j = 0, tc, 1 do
      local column = j % (iw/tw)
      local row = math.floor(j/(iw/tw))
      tiles[i] = {
        atlas = ts.image,
        quad = quad(column * tw, row * th, tw, th, iw, ih)
      }
      i = i + 1
    end
  end

  -- node factory
  for _, layer in pairs(exportedTable.layers) do
    if layer.data then
      for _, n in pairs(layer.data) do
        local atlas = tiles[1].atlas
        local quad = tiles[1].quad
        local layer = 0

        -- create node
        local tile = Node()

        -- sprite renderer component to render the sprite
        tile.spriteRenderer = SpriteRenderer(tile, atlas, quad, layer)

        self:addChild(tile)
      end
    end
  end

  ----------------------------------------------
  return self
end

return tilemap
