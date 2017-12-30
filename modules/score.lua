local function score()
  local self = {}

  ----------------------------------------------
  -- attributes
  ----------------------------------------------
  local score1, score2, score3, score4 = 0, 0, 0, 0
  local font = love.graphics.newFont(14 * scale)
  local players = 0

  ----------------------------------------------
  -- components
  ----------------------------------------------


  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)
    
  end
  
  function self:addPlayer()
    players = players + 1
    return players
  end
  
  function self:scoreUp(id)
    if id == 1 then
      score1 = score1 + 100
    elseif id == 2 then
      score2 = score2 + 100
    elseif id == 3 then
      score3 = score3 + 100
    elseif id == 4 then
      score4 = score4 + 100
    end
  end

  function self:scoreDown(id)
    if id == 1 then
      score1 = score1 - 100
    elseif id == 2 then
      score2 = score2 - 100
    elseif id == 3 then
      score3 = score3 - 100
    elseif id == 4 then
      score4 = score4 - 100
    end
  end
  
  function self:draw()
    lg.print("player1: " .. score1, 1, 1)
    lg.print("player2: " .. score1, 1, font:getHeight())
    lg.print("player3: " .. score1, 1, font:getHeight() * 2)
    lg.print("player4: " .. score1, 1, font:getHeight() * 3)
    -- debug amount of players
    lg.print("players: " .. players, 1, font:getHeight() * 4)
  end


  ----------------------------------------------
  return self
end

return score
