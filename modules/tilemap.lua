local Node = require "modules/node"
local Layer = require "modules/layer"
local SpriteRenderer = require "modules/spriteRenderer"

local quad = love.graphics.newQuad

local minimalDepth = -10000

local function tilemap(name, x, y)
  local self = Node(x, y)

  local exportedTable = require ("assets/maps/" .. name)
  -- stores all possible tilesets
  local tiles = {}

  -- populate tiles table
  local tileIndex = 1
  for _, ts in pairs(exportedTable.tilesets) do
    local atlas = lg.newImage("assets/maps/" .. ts.image)
    local tw, th = ts.tilewidth, ts.tileheight
    local iw, ih = ts.imagewidth, ts.imageheight
    local tc = ts.tilecount
    local s = ts.spacing
    local m = ts.margin

    -- add quads to tile table
    for i = 0, tc - 1, 1 do
      local column = i % (iw / (tw + s + m))
      local row = math.floor(i / (iw / (tw + s + m)))
      tiles[tileIndex] = {
        atlas = atlas,
        width = tw,
        height = th,
        quad = quad(column * (tw + s + m), row * (th + s + m), tw, th, iw, ih)
      }
      tileIndex = tileIndex + 1
    end
  end

  -- node factory
  for depth, layer in ipairs(exportedTable.layers) do
    depth = layer.properties.depth or depth + minimalDepth
    scale = layer.properties["Scale"] or 1

    -- create node
    local layerNode = Layer()
    layerNode.width = exportedTable.width * exportedTable.tilewidth
    layerNode.height = exportedTable.height * exportedTable.tileheight
    layerNode.scale = scale

    if layer.type == "tilelayer" then
      for i, n in ipairs(layer.data) do
        if n ~= 0 then
          local tile = tiles[n]

          local x = (i-1) % (layer.width)
          local y = math.floor((i-1) / layer.width)

          -- create asset information
          local asset = {
            frames = {tile.quad},
            anchorX = 0,
            anchorY = 0
          }

          -- create node
          local node = Node(x * tile.width, y * tile.height)

          -- sprite renderer component to render the sprite
          node:addComponent("spriteRenderer", {
            atlas = tile.atlas,
            asset = asset,
            layer = depth
          })

          -- add child node to layer node
          layerNode:addChild(node)
        end
      end
    elseif layer.type == "objectgroup" then
      for _, object in pairs(layer.objects) do
        -- create node
        local node = Node(object.x, object.y, object.width, object.height)

        -- add properties
        node.name = object.name
        node.type = object.type
        node.properties = object.properties

        -- table to hold the polygon's vertices
        local vertices = {}

        -- populate vertices table
        if object.polygon then
          for _, vertex in pairs(object.polygon) do
            vertices[#vertices + 1] = vertex.x
            vertices[#vertices + 1] = vertex.y
          end
        elseif object.polyline then
          for _, vertex in pairs(object.polyline) do
            vertices[#vertices + 1] = vertex
            vertices[#vertices].x = vertices[#vertices].x + object.x
            vertices[#vertices].y = vertices[#vertices].y + object.y
          end
          node.vertices = vertices
        end

        -- add collider component to collide with other collision objects
        if node.type == "trigger" or node.type == "fixture" then
          node:addComponent("collider", {
              shapeType = object.shape,
              vertices = vertices
            })
        end

        -- is the collider a sensor?
        if node.type == "trigger" then node.collider.isSensor = true end

        -- add child node to layer node
        layerNode:addChild(node)
      end
    end


    -- add layer node to tilemap node
    self:addChild(layerNode)
  end

  ----------------------------------------------
  return self
end

return tilemap
