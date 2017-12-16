local function gui()
  local self = {}
  
  ----------------------------------------------
  -- components
  ----------------------------------------------
  
  -- load GUI related stuff
  gameState = 0
  function love.load()
    local font = love.graphics.newFont("NotoSansHans-Regular.otf", 20 * scale)
    love.graphics.setFont(font)
  end


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    suit.layout:reset(100 * scale, 100 * scale)
    if suit.Button("Start!", suit.layout:row(200 * scale, 30 * scale)).hit then
      gameState = 1
    end
    if lk.isDown("escape") then
      gameState = 0
    end
  end
  
  ----------------------------------------------
  return self
end

return gui