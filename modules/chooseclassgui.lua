--[[local Node = require "modules/node"
local suit = require "lib/suit"]]
local function chooseclassgui()
  local self = {}
  local input = {text = ""}


  -- update function called each frame, dt is time since last frame
  function self:update(dt)

    suit.layout:reset(0,0)

      suit.Input(input, suit.layout:row(200,30))
      suit.Label("Hello, "..input.text, {align = "right"}, suit.layout:col(200,30))

      suit.layout:row() -- padding of one cell
      if suit.Button("Close", suit.layout:row()).hit then
          input = {text = "mag vanalles zijn"}
          gameState = 1
      end
      if #players == 1 then
        suit.Label("Hello, "..input.text, {align = "right"}, suit.layout:col(200,30))
      end
      suit.Label("Hello, "..#players, {align = "right"}, suit.layout:col(200,30))
  end

  ----------------------------------------------
  return self
end

return chooseclassgui
