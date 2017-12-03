local Node = require "modules/node"
local Tile = require "modules/tile"

local function tilemap()
  local self = Node()

  -- load atlas
  local atlas = lg.newImage("assets/images/countrysideTEST.png")

  -- load tileset
  local tileset = graphics._countryside

  -- tile dimensions
  local w, h = 32, 32

  -- the actual world, can be as big as you want
  local tilemap = {
    {3,1,1},
    {1,2,3,1},
    {1,1,1}
  }

  local heightmap = {
    {0,0,0},
    {0,1,0,0},
    {0,0,0}
  }

  -- create a node for each tilemap entry
  for row = 1, #tilemap do
    for column = 1, #tilemap[row] do
      local tile = tilemap[row][column]
      local layer = heightmap[row][column]
      local x = (column - 1) * w
      local y = (row - 1) * h

      local t = Tile(x, y, tileset, tile, layer)
      scene.rootNode:addChild(t)
    end
  end

  ----------------------------------------------
  -- methods
  ----------------------------------------------
  function self:update(dt)

  end

  function self:draw()
    for row = 1, #tilemap do
      for column = 1, #tilemap[row] do
        local tile = tilemap[row][column]
        local x = (column - 1) * w
        local y = (row - 1) * h
        lg.draw(atlas, tileset[tile], x, y)
      end
    end
  end


  ----------------------------------------------
  return self
end

return tilemap
