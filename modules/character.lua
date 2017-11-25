local Node = require "modules/node"
local Graphic = require "modules/graphic"

local function character(x, y, w, h, r, ax, ay, l)
  local self = Node(x, y, w, h, r, ax, ay)

  local atlas = lg.newImage("assets/images/atlas.png")
  local graphics = require "templates/graphics"
  local frame = graphics.kramer.walk.frames[1]
  local _, _, fw, fh = frame:getViewport()


  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- graphic component to render the sprite
  self.graphic = Graphic(self, atlas, frame, l)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or fw
  self.height = h or fh


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end


  ----------------------------------------------
  return self
end

return character
