local function graphic(w, h)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.width = w or 10
  self.height = h or 10


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:draw(x, y, r)
    local ox = self.width * 0.5
    local oy = self.height * 0.5
    local atlas = lg.newImage("assets/images/heart.png")
    local quad = lg.newQuad(0, 0, self.width, self.height, atlas:getDimensions())
    lg.draw(atlas, quad, x, y, r, 1, 1, ox, oy)
  end


  ----------------------------------------------
  return self
end

return graphic
