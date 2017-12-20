local function gui()
  local self = {}
  
  ----------------------------------------------
  -- components
  ----------------------------------------------
  
  gameState = 0
  
  -- set font
  local font = love.graphics.newFont(20 * scale)
  love.graphics.setFont(font)
  
  -- audio sliders
  local sliderM = {value = 1, min = 0, max = 1}
  local sliderE = {value = 1, min = 0, max = 1}

  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    suit.layout:reset(100 * scale, 100 * scale)
    suit.layout:padding(10 * scale, 10 * scale)
    
    -- background music slider
    suit.Label("Music", suit.layout:row(200 * scale, 20 * scale))
    suit.Slider(sliderM, suit.layout:row(200 * scale, 20 * scale))
    suit.Label(tostring(math.floor(sliderM.value * 100)).."%", suit.layout:col(200 * scale, 20 * scale))
    bgVolume(sliderM.value)
    
    suit.layout:left()
    
    -- effects music slider
    suit.Label("Effects", suit.layout:row(200 * scale, 20 * scale))
    suit.Slider(sliderE, suit.layout:row(200 * scale, 20 * scale))
    suit.Label(tostring(math.floor(sliderE.value * 100).."%"), suit.layout:col(200 * scale, 20 * scale))
    efVolume(sliderE.value)
    
    suit.layout:left()
    
    -- start game
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