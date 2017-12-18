--ik probeerde de maps te maken in aparte mappen. maar vooralsnog is dat niet gelukt,
local tileString = [[
###########
#GGG*GGGGG#
#GGGGG*GGG#
GGGGGG#GGGG
###GGG*GGG#
#**GGGGGGG#
###########
]]

local quadInfo = {
  {'G',  0,  0}, --grass
  {'B', 32,  0}, --box
  {'*',  0, 32}, --flower
  {'#', 32, 32}  --boxtop
}

newMap(32,32,"assets/images/countrysideTEST.png", tileString, quadInfo)
