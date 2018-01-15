local function spriteRenderer(node, atlas, asset, layer)
  local self = {}


  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.active = true
  node.visible = true
  node.layer = layer or 0


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:draw()

    -- position
    local x, y = node:getWorldCoords()

    -- rotation
    local r = node:getWorldRotation()

    -- scale
    local s = node:getWorldScale()

    -- frame dimensions
    local _, _, spriteWidth, spriteHeight = node.sprite:getViewport()

    -- origin offset
    local originX = node.anchorX * spriteWidth
    local originY = node.anchorY * spriteHeight

    -- size
    local sizeX = node.width / spriteWidth
    local sizeY = node.height / spriteHeight

    -- draw sprite
    lg.draw(atlas, node.sprite, x, y, r, s * sizeX, s * sizeY, originX, originY)
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
