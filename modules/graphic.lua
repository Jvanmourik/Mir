local function graphic(self, atlas, w, h)
  local self = self
  local atlas = atlas
  local w, h = w, h

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:draw(x, y, r)
    -- the quad to draw on screen
    local quad = lg.newQuad(0, 0, w, h, atlas:getDimensions())

    -- origin offset
    local ox, oy = self.anchorX * w, self.anchorY * h

    -- scale
    local sx, sy = self.width / w, self.height / h

    -- draw graphic
    lg.draw(atlas, quad, x, y, r, sx, sy, ox, oy)
  end


  ----------------------------------------------
  return self
end

return graphic
