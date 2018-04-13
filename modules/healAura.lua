local Node = require "modules/node"
local assets = require "templates/assets"


local function healAura(x,y)
  local self = Node(x, y)
  local heal = 1
  local healtimer = 90
  self.existing = 900
  self.active = true
--Add aura for healing
  self:addComponent("collider", {
    shapeType = "circle",
    radius = 100
  })

  self.collider.active = true
  self.collider.isSensor = true

  function self:onCollisionEnter(dt, other, delta)
    if other.healing and type(other.healing) == "function" then
      other:healing(heal, healtimer)
    end
  end

  function self:onCollisionExit(dt, other, delta)
    if other.endhealing and type(other.endhealing) == "function" then
      other:endhealing(healtimer)
    end
  end

  function self:update(dt)
    if self.active == true then
      self.existing = self.existing - 1
      if self.existing <= 0 then
        self.collider.active = false
        for _, player in pairs(players) do
  			     if player.active then
               player.endhealing(healtimer)
             end
  		  end
        self.active = false
      end
    end
  end
  return self
end

return healAura
