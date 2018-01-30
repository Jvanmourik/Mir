local Node = require "modules/node"

local function lives(x, y, w, h, r, s, ax, ay, l)
  local self = Node(x, y, w, h, r, s, ax, ay, l)

  local assets = require "templates/assets"

  ----------------------------------------------
  -- attributes
  ----------------------------------------------

  self.name = "lives"
  self.anchorX, self.anchorY = 0.5, 0.5
  teamLives = 5

  ----------------------------------------------
  -- components
  ----------------------------------------------

  -- sprite renderer component to render the sprite
  self:addComponent("spriteRenderer",
  { atlas = assets.lives.atlas,
    asset = assets.lives.five,
    layer = 100 })

  self.scale = 0.5

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  -- update function called each frame, dt is time since last frame
  function self:update(dt)
    if teamLives == 4 then
      self.spriteRenderer:setSprite(assets.lives.four)
    elseif teamLives == 3 then
      self.spriteRenderer:setSprite(assets.lives.three)
    elseif teamLives == 2 then
      self.spriteRenderer:setSprite(assets.lives.two)
    elseif teamLives == 1 then
      self.spriteRenderer:setSprite(assets.lives.one)
    elseif teamLives == 0 then
      self.spriteRenderer:setSprite(assets.lives.zero)
    end
  end

  ----------------------------------------------
  return self
end

return lives
