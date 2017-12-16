local function spriteRenderer(node, sprite, layer)
  local self = {}

  local atlas = lg.newImage("assets/images/atlas.png")

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  node.sprite = sprite
  node.visible = true
  node.layer = layer or 0


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:draw(x, y, r)
    -- frame dimensions
    local _, _, spriteWidth, spriteHeight = node.sprite:getViewport()

    -- origin offset
    local originX = node.anchorX * spriteWidth
    local originY = node.anchorY * spriteHeight

    -- draw sprite
    lg.draw(atlas, node.sprite, x, y, r, scale, scale, originX, originY)
  end


  ----------------------------------------------
  return self
end

return spriteRenderer
