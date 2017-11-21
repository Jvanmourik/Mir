local function graphic(node, atlas, quad, l)
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.visible = true
  self.layer = l or 0


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:draw(x, y, r)
    -- texture dimensions
    local sw, sh = quad:getTextureDimensions()

    -- origin offset
    local ox, oy = node.anchorX * sw, node.anchorY * sh

    -- scale
    local sx, sy = node.width / sw, node.height / sh

    -- draw graphic
    lg.draw(atlas, quad, x, y, r, sx, sy, ox, oy)
  end


  ----------------------------------------------
  return self
end

return graphic
