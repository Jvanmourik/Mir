local function gui()
  local self = {}

  ----------------------------------------------
  -- components
  ----------------------------------------------

  gameState = 0
  local scale = scale

  -- set font
  local font = love.graphics.newFont(14 * scale)
  love.graphics.setFont(font)

  -- audio sliders
  local sliderM = {value = 1, min = 0, max = 1}
  local sliderE = {value = 1, min = 0, max = 1}
  local fsCheck = {text = "Fullscreen"}

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

    suit.Checkbox(fsCheck, suit.layout:row())
    if fsCheck.checked then
      lw.setFullscreen(true)
    else
      if lw.getFullscreen() then
        lw.setFullscreen(false)
        lw.setMode(800, 600)
      end
    end

    -- start game
    if gameState == 0 then
      if suit.Button("Start!", suit.layout:row(200 * scale, 30 * scale)).hit then
        gameState = 3
      end
    elseif gameState == 2 then
      if suit.Button("Continue!", suit.layout:row(200 * scale, 30 * scale)).hit then
        gameState = 1
      end
      if suit.Button("Quit", suit.layout:col(200 * scale, 30 * scale)).hit then
        le.quit()
      end
    end
  end

  ----------------------------------------------
  return self
end

return gui
