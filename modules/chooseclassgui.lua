--[[local Node = require "modules/node"
local suit = require "lib/suit"]]
local function chooseclassgui()
  local self = {}
  local input = {text = ""}
  local nrOfPlayersChosen = false
  local ChooseCharacters = false
  local p1picked = false
  local p2picked = false
  local p3picked = false
  local p4picked = false

  -- update function called each frame, dt is time since last frame
  function self:update(dt)

    suit.layout:reset(100,100)
    suit.layout:padding(10)
      if nrOfPlayersChosen == false then
        suit.Label("How many players wish to play?", {align = "left"}, suit.layout:row(300, 30))

        self:createButtonSelectnrPlayers("one", 200, 30)
        self:createButtonSelectnrPlayers("two", 200, 30)
        self:createButtonSelectnrPlayers("three", 200, 30)
        self:createButtonSelectnrPlayers("four", 200, 30)
        suit.layout:left()
      end

      if nrOfPlayersChosen == true and ChooseCharacters == false then
        suit.Label("You have chosen " ..input.text, {align = "left"}, suit.layout:row(400, 30))
        suit.Label("Every type of character can only get picked once. A healer drops a healing aura, a stunner can stun enemies, A speed buffer can increase allies speed and a warrior deals more damage but has no skills", {align = "left"}, suit.layout:row(600, 30))
        suit.layout:row(30,30)
        if suit.Button("Continue", suit.layout:row(70, 30)).hit then
          ChooseCharacters = true
        end
        if suit.Button("Back", suit.layout:col(60, 30)).hit then
          nrOfPlayersChosen = false
        end
      end

      if ChooseCharacters == true then
        if nrOfPlayers == 1 then
          suit.Label("You want to be a ...", {align = "left"} ,suit.layout:row(200,30))
          if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerOneType = "healer" gameState = 1 end
          if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerOneType = "stunner" gameState = 1 end
          if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerOneType = "speedBuffer" gameState = 1 end
          if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerOneType = "warrior" gameState = 1 end
        elseif nrOfPlayers == 2 then
          if p1picked == false then
            suit.Label("Player 1 is a ...", {align = "left"} ,suit.layout:row(200,30))
            if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerOneType = "healer" p1picked = true end
            if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerOneType = "stunner" p1picked = true end
            if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerOneType = "speedBuffer" p1picked = true end
            if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerOneType = "warrior" p1picked = true end
          end
          if p1picked == true and p2picked == false then
            suit.Label("Player 2 is a ...", {align = "left"} ,suit.layout:row(200,30))
            if PlayerOneType == "healer" then
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" gameState = 1 end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" gameState = 1 end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" gameState = 1 end
            elseif PlayerOneType == "Stunner" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" gameState = 1 end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" gameState = 1 end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" gameState = 1 end
            elseif PlayerOneType == "speedBuffer" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" gameState = 1 end
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" gameState = 1 end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" gameState = 1 end
            elseif PlayerOneType == "warrior" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" gameState = 1 end
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" gameState = 1 end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" gameState = 1 end
            end
          end
        elseif nrOfPlayers == 3 then
          if p1picked == false then
            suit.Label("Player 1 is a ...", {align = "left"} ,suit.layout:row(200,30))
            if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerOneType = "healer" p1picked = true end
            if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerOneType = "stunner" p1picked = true end
            if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerOneType = "speedBuffer" p1picked = true end
            if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerOneType = "warrior" p1picked = true end
          end
          if p1picked == true and p2picked == false then
            suit.Label("Player 2 is a ...", {align = "left"} ,suit.layout:row(200,30))
            if PlayerOneType == "healer" then
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" p2picked = true end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" p2picked = true end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" p2picked = true end
            elseif PlayerOneType == "Stunner" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" p2picked = true end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" p2picked = true end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" p2picked = true end
            elseif PlayerOneType == "speedBuffer" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" p2picked = true end
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" p2picked = true end
              if suit.Button("Warrior", suit.layout:row(100, 30)).hit then PlayerTwoType = "warrior" p2picked = true end
            elseif PlayerOneType == "warrior" then
              if suit.Button("Healer", suit.layout:row(100, 30)).hit then PlayerTwoType = "healer" p2picked = true end
              if suit.Button("Stunner", suit.layout:row(100, 30)).hit then PlayerTwoType = "stunner" p2picked = true end
              if suit.Button("Speed buffer", suit.layout:row(100, 30)).hit then PlayerTwoType = "speedBuffer" p2picked = true end
            end
          end
          if p2picked == true and p3p3picked == false then
            if PlayerOneType == "healer" and PlayerTwoType == "Stunner" then end

          end
        elseif nrOfPlayers == 4 then
        end
      end
  end


  function self:createButtonSelectnrPlayers(n, x ,y)
    if suit.Button(n, suit.layout:row(x, y)).hit then
      nrOfPlayersChosen = true
      if n == "one" then
        input = {text = "one player"}
        nrOfPlayers = 1
      elseif n == "two" then
        nrOfPlayers = 2
        input = {text = "two players"}
      elseif n == "three" then
        nrOfPlayers = 3
        input = {text = "three players"}
      elseif n == "four" then
        nrOfPlayers = 4
        input = {text = "four players"}
      end
    end
  end

  ----------------------------------------------
  return self
end

return chooseclassgui
