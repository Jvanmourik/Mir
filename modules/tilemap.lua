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
      local column = j % (iw / tw)
      local row = math.floor(j / (iw / tw))
      tiles[i] = {
        atlas = ts.image,
        width = tw,
        height = th,
        quad = quad(column * tw, row * th, tw, th, iw, ih)
      }
      i = i + 1
    end
  end

  -- node factory
  for _, layer in pairs(exportedTable.layers) do
    -- layer.width, layer.height
    local i = 0
    if layer.data then
      for _, n in pairs(layer.data) do
        if n ~= 0 then
          local tile = tiles[n]

          local atlas = "maps/" .. tile.atlas

          local x = i % (layer.width - 1)
          local y = math.floor(i / layer.width)

          local asset = {
            frames = {tile.quad},
            anchorX = 0,
            anchorY = 0
          }

          -- create node
          local node = Node(x * tile.width, y * tile.height)

          -- sprite renderer component to render the sprite
          node.spriteRenderer = SpriteRenderer(node, atlas, asset, 0)

          self:addChild(node)
        end
        i = i + 1
      end
    end
  end

  ----------------------------------------------
  return self
end

return tilemap
