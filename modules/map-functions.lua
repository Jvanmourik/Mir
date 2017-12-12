local tileW, tileH, tileset, quads, tileTable

function loadMap()
  --alle code in loadmap() wilde ik eigenlijk in assets/maps/ hebben staan, maar dat kreeg ik niet werkende
  local tileString = [[
###########
#         #
#     *   #
*     #   *
###   *   #
#**       #
###########
]]

  local quadInfo = {
    {' ',  0,  0}, --grass
    {'B', 32,  0}, --box
    {'*',  0, 32}, --flower
    {'#', 32, 32}  --boxtop
  }

  newMap(32,32,"assets/images/countrysideTEST.png", tileString, quadInfo)
end

function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)

  tileW = tileWidth
  tileH = tileHeight
  tileset = lg.newImage(tilesetPath)

  local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()

  quads = {}

  for _,info in ipairs(quadInfo) do
    -- info[1] = the symbol, info[2] = x, info[3] = y
    quads[info[1]] = lg.newQuad(info[2], info[3], tileW,  tileH, tilesetW, tilesetH)
  end

  tileTable = {}

  local width = #(tileString:match("[^\n]+"))

  for x = 1,width,1 do tileTable[x] = {} end

  local rowIndex,columnIndex = 1,1
  for row in tileString:gmatch("[^\n]+") do --("[^\n]+") kijkt naar de lengte van de eerste string in tileString
    assert(#row == width, 'Map is not aligned: width of row ' .. tostring(rowIndex) .. ' should be ' .. tostring(width) .. ', but it is ' .. tostring(#row))
    columnIndex = 1
    for symbol in row:gmatch(".") do
      tileTable[columnIndex][rowIndex] = symbol
      columnIndex = columnIndex + 1
    end
    rowIndex=rowIndex+1
  end

end

function drawMap()
  for columnIndex,column in ipairs(tileTable) do
    for rowIndex,symbol in ipairs(column) do
      local x,y = (columnIndex-1)*tileW, (rowIndex-1)*tileH
      lg.draw(tileset, quads[ symbol ] , x, y)
    end
  end
end
