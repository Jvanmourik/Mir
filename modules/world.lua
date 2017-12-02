function loadworld()

-- declare shorthand newQuad
local quad = love.graphics.newQuad

--load tileset
Tileset = lg.newImage("assets/images/countrysideTEST.png")

TileW, TileH = 32, 32
local tilesetW, tilesetH = Tileset:getWidth(), Tileset:getHeight()

--all different tile sprites:
Quads = {
  quad(0,   0, TileW, TileH, tilesetW, tilesetH), -- 1 = grass
  quad(32,  0, TileW, TileH, tilesetW, tilesetH), -- 2 = box
  quad(0,  32, TileW, TileH, tilesetW, tilesetH), -- 3 = flowers
  quad(32, 32, TileW, TileH, tilesetW, tilesetH)  -- 4 = boxtop
}

-- the actual world, can be as big as you want
TileTable = {
  {3,1,1},
  {1,2,3,1},
  {1,1,1}
}
end

function drawworld()
  for rowIndex=1, #TileTable do
      local row = TileTable[rowIndex]
      for columnIndex=1, #row do
        local number = row[columnIndex]
        local x = (columnIndex-1)*TileW
        local y = (rowIndex-1)*TileH
        lg.draw(Tileset, Quads[number], x, y)
      end
    end
end
