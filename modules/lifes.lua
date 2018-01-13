local function lifes()
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------
  local lifes = 5
  local font = love.graphics.newFont(14 * scale)

  ----------------------------------------------
  -- components
  ----------------------------------------------


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    
  end
  
  function self:lifeDown()
    if lifes > 0 then
      lifes = lifes - 1
  end
  
  function self:draw()
    lg.print("lifes: " .. lifes, 1, font:getHeight() * 5)
  end


  ----------------------------------------------
  return self
end

return lifes
