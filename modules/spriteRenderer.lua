local function spriteRenderer(node, file, asset, layer)
  local self = {}

  local file = file or "atlas.png"
  local atlas = lg.newImage("assets/" .. file)


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true
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

    -- size
    local sizeX = node.width / spriteWidth
    local sizeY = node.height / spriteHeight

    -- draw sprite
    lg.draw(atlas, node.sprite, x, y, r,
      node.scale * sizeX, node.scale * sizeY, originX, originY)
  end

  function self:setSprite(asset, frame)
    local frame = frame or 1
    local sprite = asset.frames[frame]
    local _, _, spriteWidth, spriteHeight = sprite:getViewport()
    local anchorX, anchorY = asset.anchorPoint

    node.sprite = sprite
    node.width = spriteWidth
    node.height = spriteHeight
    node.anchorX, node.anchorY = asset.anchorX, asset.anchorY
  end

  self:setSprite(asset)

  ----------------------------------------------
  return self
end

return spriteRenderer
