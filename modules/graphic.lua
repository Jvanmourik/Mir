local function graphic(node, atlas, frame, l)
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
    -- frame dimensions
    local _, _, fw, fh = frame:getViewport()

    -- origin offset
    local ox, oy = node.anchorX * fw, node.anchorY * fh

    -- scale
    local sx, sy = node.width / fw, node.height / fh

    -- draw graphic
    lg.draw(atlas, frame, x, y, r, sx, sy, ox, oy)
  end


  ----------------------------------------------
  return self
end

return graphic
