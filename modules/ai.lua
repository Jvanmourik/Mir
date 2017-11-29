local function ai(node)
  local self = {}


  ----------------------------------------------
  -- attributes
  ----------------------------------------------




  ----------------------------------------------
  -- methods
  ----------------------------------------------

  function self:update(dt)

  end

  function self:follow(secondnode)
    --love.graphics.print(self.x)
    --love.graphics.print(secondnode.x)
    if(self.x > secondnode.x) then
      self.x = self.x - 5
    else
      self.x = self.x + 5
    end
    if(self.y > secondnode.y) then
      self.y = self.y - 5
    else
      self.y = self.y + 5
    end
  end

  function self:dodge(secondnode)
    if(self.x > node.x) then
      self.x = self.x + 5
    else
      self.x = self.x - 5
    end
    if(self.y > node.y) then
      self.y = self.y + 5
    else
      self.y = self.y - 5
    end
  end


  ----------------------------------------------
  return self
end

return ai
